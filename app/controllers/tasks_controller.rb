class TasksController < ApplicationController
    
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show,:edit,:update,:destroy]
    
    
    def index
        if logged_in?
            @task = current_user.tasks.build
            @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(3)
        end
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        if @task.save
            flash[:success] = 'タスクは登録されました'
            redirect_to root_url
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
       params.require(:task).permit(:content, :status) 
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @micropost
            redirect_to root_url
        end
    end
    
  
end
