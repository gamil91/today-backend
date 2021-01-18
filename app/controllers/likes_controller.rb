class LikesController < ApplicationController

    def create
        like = Like.new(blog_id: params[:blog_id], user_id: current_user.id)
        # byebug
        if like.save
            render json: like
        else
            render json: like.errors.full_messages
        end
    end

    def destroy
        like = Like.find(params[:id])
        like.destroy
        render json: like
    end

    def get_likes
        liked_blogs = Like.all.select {|like| like.user_id === current_user.id} 
        render json: liked_blogs
    end

    private

    def like_params
        params.permit(:id, :blog_id)
    end

end
