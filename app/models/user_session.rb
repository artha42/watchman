class UserSession < Authlogic::Session::Base
  attr_accessor :redirect_path
end
