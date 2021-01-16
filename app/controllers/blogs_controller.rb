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
        blog = Blog.new(user_id: current_user.id, title: params[:title], content: params[:content], private: params[:private])
        if blog.save
            render json: {user: UserSerializer.new(current_user)}
        else
            render json: blog.errors.full_messages
        end
    end

    def update
        blog = Blog.find(params[:id])
        if blog.update(blog_params)
            render json: {user: UserSerializer.new(current_user)}
        else
            render json: blog.errors.full_messages
        end
    end

    def destroy
        blog = Blog.find(params[:id])
        blog.destroy
        render json: blog
    end


    private

    def blog_params
        params.permit(:id, :title, :content, :private)
    end
    
end
