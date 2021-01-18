class CommentsController < ApplicationController

    def create
        comment = Comment.new(comment: params[:comment], blog_id: params[:blog_id], user_id: current_user.id)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages
        end
    end

    def update
        comment = Comment.find(params[:id])
        if comment.update(comment_params)
            render json: comment
        else
            render json: comment.errors.full_messages
        end
    end

    def destroy
        byebug
        comment = Comment.find(params[:id])
        comment.destroy
        render json: comment
    end

    private

    def comment_params
        params.permit(:id, :comment, :blog_id)
    end

end
