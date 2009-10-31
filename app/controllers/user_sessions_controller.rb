class UserSessionsController < ApplicationController
  def index
    redirect_to root_path
  end

  def new
    @user_session = UserSession.new
    @user_session.redirect_path=request.GET[:redirect_path]
  end
  
  def create 
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "User logged in successfully"
      if(params[:user_session][:redirect_path])
        redirect_to CGI::unescape(params[:user_session][:redirect_path])
        return
      else
        redirect_to root_path
        return
      end
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
    flash[:notice] = ""
    destroy
  end
end
