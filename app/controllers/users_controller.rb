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
    @users = User.find(:all)
    respond_to do |format|
      format.html
      format.json {        
        return_array =[]
        p = {}
        @users.each do |user|
          last_login = user.last_login_at && "#{time_ago_in_words(user.last_login_at)} ago"
          return_array << [ user.id,
                            user.username,
                            user.email,
                            user.login_count,
                            last_login ||="never",
                            user.last_login_ip||="never"
                            ]
        end
        p[:aaData] = return_array
        render :json=>p.to_json
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
