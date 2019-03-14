class TasksController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :set_task,only:[:show,:edit,:update,:destroy]
    def index
      if logged_in?
       @task =current_user.tasks.order(created_at: :desc).page(params[:page]).per(10)
      end
    end
    
    def show
    end
    
    def new
        @task =current_user.tasks.build
    end
    
    def create
        @task =current_user.tasks.build(task_params)
        
        if @task.save
          flash[:success]='タスクが正常に投稿されました'
          redirect_to @task
        else
          flash.now[:danger]='タスクが投稿されませんでした'
          render :new
        end
    end
    
    def edit
    end
    
    def update

      if @task.update(task_params)
        flash[:success] = 'タスクは正常に更新されました'
        redirect_to @task
      else
        flash.now[:danger] = 'タスクは更新されませんでした'
        render :edit
      end 
    end
    
    def destroy
      
      @task.destroy
      
      flash[:success]='タスクが正常に投稿されました'
      redirect_to tasks_url
    end
    
    private
    
    def set_task
      @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content,:status)
    end
    def require_user_logged_in
    unless logged_in?
      redirect_to signup_url
    end
  end
end
