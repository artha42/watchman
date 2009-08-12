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
    respond_to  do |format|
      format.html
      format.json {
        return_array = []
        @users.each do |user|
          o={}
          o[:id]=user.id
          o[:cell]=[user.id,user.username,user.email]
          return_array << o
        end
        render :json=>return_array.to_json
      }
    end
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
end
