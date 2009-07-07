class AdminController < ApplicationController
  before_filter :authenticate
  before_filter :ensure_admin
  def ensure_admin
    if(not is_admin?)
      render :text=>"must be an admin to access these controllers"
    end
  end
end
