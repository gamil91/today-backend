class TasksController < ApplicationController

    def create
        task = Task.new(name: params[:name], list_id: params[:list_id])
        if task.save
            render json: task
        else
            render json: task.errors.full_messages
        end
    end


    def update
        task = Task.all.find(params[:id])
        if task.update(task_params)
            render json:task
        else
            render json: task.errors.full_messages
        end

    end

    def destroy
        task = Task.all.find(params[:id])
        task.destroy
        render json: task
    end

    private
    
    def task_params
        params.permit(:name, :finished, :id)
    end

end
