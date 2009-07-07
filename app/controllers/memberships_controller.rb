class MembershipsController < ApplicationController
  before_filter :ensure_entities
  def create
    if(not @group.users.index(@user))
      @group.users << @user
    end
    redirect_to group_path(@group.id)
  end
  def destroy
    if(@group.users.index(@user))
      @group.users.delete(@user)
    end
    redirect_to group_path(@group.id)
  end
  def ensure_entities
    group_id = params[:group_id]
    user_id = params[:user_id]
    begin
      @group = Group.find(group_id)
      @user = User.find(user_id)
    rescue ActiveRecord::RecordNotFound => nfe
      render :text=>"User id or the Group id passed is invalid", :status => 500
    end
  end
end
