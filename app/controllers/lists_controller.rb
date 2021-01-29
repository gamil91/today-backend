class ListsController < ApplicationController


    def create
        list = List.new(title: params[:title], user_id: current_user.id)
        list_number = current_user.lists.length
        list.order_number = list_number + 1
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
        
        lists = current_user.lists
            lists.map do |list|
                list.order_number -= 1
                list.save
            end
        render json: list
    end

    def order_lists
        order = 1
        lists = params[:lists_array]
        lists.each do |id|
            list = List.all.find(id)
            list.order_number = order
            order += 1
            list.save
        end
        render json: {message: "Updated"}
    end

    def get_lists
        users_lists = List.all.select do |list| list.user_id === current_user.id end
        sorted = users_lists.sort_by{|task| task.order_number}
        render json: sorted
    end

    private
    
    def list_params
        params.permit(:title, :id, :lists_array, :user_id)
    end

end
