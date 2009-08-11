class UsersController < AdminController
  layout "admin"
  def new
    @user = User.new
  end
  def show
    @user=User.find(params[:id])
  end
  def index
    @users = User.find(:all)
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to users_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update    
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
  
  def change_password
    @user = current_user
  end

  def update_password    
    @user_before_check = params[:user][:old_password]
    @user = User.find(params[:id])
    
      if @user.valid_password?(@user_before_check)
        if @user.update_attributes(params[:user])
          flash[:notice] = "Successfully updated user."
          redirect_to root_path
        else
          render :action => 'change_password'
        end
      else
        redirect_to :action =>'change_password'
        flash[:notice] = "Old Password is wrong or blank"
      end    
  end
end
