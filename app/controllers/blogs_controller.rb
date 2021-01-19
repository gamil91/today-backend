class BlogsController < ApplicationController

    def index
        blogs = Blog.all
        render json: blogs
        
    end

    def show
        blog = Blog.find(params[:id])
        render json: blog
    end
    
    def create
        # byebug
        if params[:token]
            user_id = JWT.decode(params[:token], ENV['JWT_SECRET'])[0]['user_id']
            blog = Blog.new(user_id: user_id, title: params[:title], content: params[:content], private: params[:private])

            if blog.save
                if params[:image]
                    image = Cloudinary::Uploader.upload(params[:image])
                    imageURL = image["url"]
                    blog.update(image: imageURL)
                end
                render json: blog
            else
                render json: blog.errors.full_messages
            end

        else
            blog = Blog.new(user_id: current_user.id, title: params[:title], content: params[:content], private: params[:private])
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

            if params[:image].length > 0
                if blog.update(blog_params)
                    render json: blog
                else
                    render json: blog.errors.full_messages
                end

            else
            
                if blog.image.is_a? String
                    if blog.image.length > 0
                    oldImageId = blog.image.split("/")[7].split(".")[0]
                    Cloudinary::Uploader.destroy(oldImageId)
                    end
                end

                if blog.update(blog_params)
                    render json: blog
                else
                    render json: blog.errors.full_messages
                end
            end

        else
            # byebug
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



    # def update
    #     blog = Blog.find(params[:id])
    #     byebug
    #     if params[:image].length > 0
            
    #         if blog.update(blog_params)
    #             render json: blog
    #         else
    #             render json: blog.errors.full_messages
    #         end

    #     elsif params[:image].length == 0
            
    #         if blog.image != nil
    #             oldImageId = blog.image.split("/")[7].split(".")[0]
    #             Cloudinary::Uploader.destroy(oldImageId)
    #         end

    #         if blog.update(blog_params)
    #             render json: blog
    #         else
    #             render json: blog.errors.full_messages
    #         end

    #     else
            
    #         if blog.image != nil
    #             oldImageId = blog.image.split("/")[7].split(".")[0]
    #             Cloudinary::Uploader.destroy(oldImageId)
    #         end

    #         new_image = Cloudinary::Uploader.upload(params[:image])
    #         newImageURL = new_image["url"]
    #         if blog.update(title: params[:title], content: params[:content], private:params[:private], image: newImageURL)
    #             render json: blog
    #         else
    #             render json: blog.errors.full_messages
    #         end

    #     end
    # end

    def destroy
        blog = Blog.find(params[:id])
        cloudinaryId = blog.image.split("/")[7].split(".")[0]
        res = Cloudinary::Uploader.destroy(cloudinaryId)
        # byebug
        blog.destroy
        render json: blog
    end


    private

    def blog_params
        params.permit(:id, :title, :content, :private, :image)
    end
    
end
