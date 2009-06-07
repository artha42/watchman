class UserSessionsController < ApplicationController
  def index
    redirect_to root_path
  end

  def new
    @user_session = UserSession.new
  end
  
  def create 
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "User logged in successfully"
      redirect_to root_path
    else
      flash[:error] = "Something went wrong"
      render :action => 'new'
    end
  end
  
  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url
  end

  def logout
    destroy
  end
end
