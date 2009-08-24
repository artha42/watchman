class GroupsController < AdminController
  def index
    @groups=Group.find(:all)
  end
  def show
    @group=Group.find(params[:id])
  end
  def new
    @group = Group.new
  end
  def create
    @group=Group.new(params[:group])
    if(@group.save)
      flash[:notice]="Group was created successfully"
      redirect_to groups_path
    else
      flash[:error]="Group could not be created successfully"
      render :action=>:new
    end
  end
  def destroy
    @group=Group.find(params[:id])
    @group.delete
  end
end
