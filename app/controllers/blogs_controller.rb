class BlogsController < ApplicationController

    def index
        blogs = Blog.all
        render json: blogs
      
    end

    def show
        blog = Blog.find(params[:id])
        render json: BlogSerializer.new(blog)
    end
    
    def create
        # byebug
        if params[:token]
            user_id = JWT.decode(params[:token], ENV['JWT_SECRET'])[0]['user_id']

            image = Cloudinary::Uploader.upload(params[:image])
            imageURL = image["url"]
            blog = Blog.new(user_id: user_id, image:imageURL, title: params[:title], content: params[:content], private: params[:private])

            if blog.save
                render json: blog
            else
                render json: blog.errors.full_messages
            end

        else
            blog = Blog.new(user_id: current_user.id, title: params[:title], content: params[:content], private: params[:private], image:params[:image])
            if blog.save
                render json: blog
            else
                render json: blog.errors.full_messages
            end
        end
    end

    
    def update
        blog = Blog.find(params[:id])
        
        if params[:image].is_a? String
            #is the params[:image] not an empty string?
            if params[:image].length > 0
                if blog.update(blog_params)
                    render json: blog
                else
                    render json: blog.errors.full_messages
                end
            #if it is empty, check to see if this blog has an image in the db
            #if so, go ahead and destroy it in the cloud
            else
                if blog.image.length > 0
                    oldImageId = blog.image.split("/")[7].split(".")[0]
                    Cloudinary::Uploader.destroy(oldImageId)
                end
                
                if blog.update(blog_params)
                    render json: blog
                else
                    render json: blog.errors.full_messages
                end
         
            end
                

        else
            
            if blog.image.is_a? String
                if blog.image.length > 0
                oldImageId = blog.image.split("/")[7].split(".")[0]
                Cloudinary::Uploader.destroy(oldImageId)
                end
            end

            new_image = Cloudinary::Uploader.upload(params[:image])
            newImageURL = new_image["url"]
            if blog.update(title: params[:title], content: params[:content], private:params[:private], image: newImageURL)
                render json: blog
            else
                render json: blog.errors.full_messages
            end

        end
    end



    def destroy
        blog = Blog.find(params[:id])
        if blog.image.is_a? String
            if blog.image.length > 0
            oldImageId = blog.image.split("/")[7].split(".")[0]
            Cloudinary::Uploader.destroy(oldImageId)
            end
        end
        # byebug
        blog.destroy
        render json: blog
    end


    private

    def blog_params
        params.permit(:id, :title, :content, :private, :image)
    end
    
end
