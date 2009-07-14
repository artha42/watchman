class RolesController < ApplicationController
  before_filter :ensure_instance
  def index
    @roles=Kernel::const_get(@scope).roles
  end
  def edit
    @role_sym=params[:role]
    @role=Role.find_by_name_and_scope_and_instance_id(@role_sym,@scope,@instance_id)
    @rest_users = User.find(:all) - @role.users
    @rest_groups = Group.find(:all) - @role.groups
  end
  def user_assign
    @role_sym=params[:role]
    @role=Role.find_or_create_by_name_and_scope_and_instance_id(@role_sym,@scope,@instance_id)
    u=User.find(params[:user_id])
    if(@instance.assign(@role_sym.to_sym,:to=>u))
      redirect_to edit_role_path(@scope,@instance_id,@role_sym)
    end
  end
  def user_revoke
    @role_sym=params[:role]
    @role=Role.find_or_create_by_name_and_scope_and_instance_id(@role_sym,@scope,@instance_id)
    u=User.find(params[:user_id])
    if(@instance.revoke(@role_sym.to_sym,:from=>u))
      redirect_to edit_role_path(@scope,@instance_id,@role_sym)
    end
  end
  def group_assign
    @role_sym=params[:role]
    puts @role_sym
    @role=Role.find_or_create_by_name_and_scope_and_instance_id(@role_sym,@scope,@instance_id)
    puts @role
    g=Group.find(params[:group_id])
    if(@instance.assign(@role_sym.to_sym,:to=>g))
      redirect_to edit_role_path(@scope,@instance_id,@role_sym)
    end
  end
  def group_revoke
    @role_sym=params[:role]
    @role=Role.find_or_create_by_name_and_scope_and_instance_id(@role_sym,@scope,@instance_id)
    g=Group.find(params[:group_id])
    if(@instance.revoke(@role_sym.to_sym,:from=>g))
      redirect_to edit_role_path(@scope,@instance_id,@role_sym)
    end
  end
  protected
  def ensure_instance
    @scope=params[:scope]
    @instance_id=params[:instance_id]
    begin
      @instance=Kernel::const_get(@scope).find(@instance_id)
    rescue NameError => ne
      render :text=>"No such class found. Have you misspelt the model?" + ne
    rescue ActiveRecord::RecordNotFound => rnf
      render :text=>"No such record found and hence no security risk."
    end
  end
end
