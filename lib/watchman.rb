require 'watchmen_routes.rb'

%w{ models controllers helpers } do |dir|
  path = File.join(File.dirname(__FILE__),"app",dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths.add(path)
  ActiveSupport::Dependencies.load_once_path.delete(path)
end
