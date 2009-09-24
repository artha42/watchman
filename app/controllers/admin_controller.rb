class AdminController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_admin
  before_filter :user_profile
  def ensure_admin
    if(not is_admin?)
      render :text=>"must be an admin to access these controllers"
    end
  end
end
