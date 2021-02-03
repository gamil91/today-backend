class TasksController < ApplicationController

    def create
        task = Task.new(name: params[:name], list_id: params[:list_id])
        task_number = List.all.find(params[:list_id]).tasks.length
        task.order_number = task_number + 1
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
        list_id = task.list_id
        task.destroy
        
        tasks =  Task.all.select do |task| task.list_id === list_id end
        tasks.map do |task| 
            task.order_number -= 1 
            task.save
        end
        render json: task
    end

    def order_tasks
        if params[:list_id]
            list = List.all.find(params[:list_id])
            current_tasks = list.tasks.map do |task| task.id end
            task_id = (params[:tasks_array] - current_tasks).join.to_i
            task = Task.all.find(task_id)
            task.list_id = params[:list_id].to_i
            task.save
        end

        order = 1
        tasks = params[:tasks_array]
        tasks.each do |id|
            task = Task.all.find(id)
            task.order_number = order
            order += 1
            task.save
        end
        render json: {message: "Updated"}
    end


    private
    
    def task_params
        params.permit(:name, :finished, :id, :tasks_array, :list_id)
    end

end
