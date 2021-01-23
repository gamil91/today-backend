class ListsController < ApplicationController


    def create
        list = List.new(title: params[:title], user_id: current_user.id)
        if list.save
            render json: list
        else
            render json: list.errors.full_messages
        end
    end


    def update
        list = List.all.find(params[:id])
        if list.update(title: params[:title])
            render json:list
        else
            render json: list.errors.full_messages
        end
    end

    def destroy
        list = List.all.find(params[:id])
        list.destroy
        render json: list
    end

    private
    
    def list_params
        params.permit(:title, :id)
    end

end
