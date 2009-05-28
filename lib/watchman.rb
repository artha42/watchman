require 'rubygems'
require 'activesupport'
require 'activerecord'
require 'actionpack'
require 'authlogic'
require 'watchman/watchman_errors.rb'
require 'watchman/extensions.rb'

%w{ models controllers helpers }.each do |dir|
  path = File.join(File.dirname(__FILE__),"app",dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end
