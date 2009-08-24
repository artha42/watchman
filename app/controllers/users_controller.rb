class UsersController < AdminController
  #we really should not be doing this but we need it for time_ago_in_words
  include ActionView::Helpers::DateHelper 
  layout "admin"
  def new
    @user = User.new
  end
  def show
    @user=User.find(params[:id])
  end
  def index
    if(params.has_key? :group_id)
      @users=Group.find(params[:group_id]).users
    else
      @users = User.find(:all)
    end
    respond_to do |format|
      format.html
      format.json {        
        puts JSON.parser.to_s
        render :json=>@users.to_json
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
