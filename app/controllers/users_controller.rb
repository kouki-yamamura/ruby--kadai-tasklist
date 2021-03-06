class UsersController < ApplicationController

  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success]="登録しました"
      redirect_to  login_path
    else
      flash[:danger]="登録失敗しました"
      render :new
    end
    
  end
end

private

 def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
