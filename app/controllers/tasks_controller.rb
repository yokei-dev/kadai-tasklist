class TasksController < ApplicationController
    
    
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = 'タスクは登録されました'
            redirect_to @task
        else
            flash[:danger] = 'タスクは登録されませんでした'
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        if @task.update(task_params)
            flash[:success] = 'タスクは編集されました'
            redirect_to @task
        else
            flash[:danger] = 'タスクは編集されませんでした'
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        flash[:success] = 'タスクは削除されました'
        redirect_to tasks_path
    end
    
    private
    
    def task_params
       params.require(:task).permit(:content) 
    end
    
end
