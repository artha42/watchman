ENV['RAILS_ENV'] = 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + "/../../../.."


require 'rubygems'
require 'pp'
require 'active_support'
require 'active_support/test_case'
ActiveSupport::TestCase::RAILS_ROOT = ENV['RAILS_ROOT']

require 'active_record'
require 'active_record/test_case'
require 'action_pack'
require 'action_controller'
require 'test_help'
require 'shoulda'
require File.expand_path(File.join(ENV['RAILS_ROOT'],'config/environment.rb'))
def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + "/database.yml"))
  ActiveRecord::Base.establish_connection(config['sqlite3'])
  load(File.dirname(__FILE__) + "/test_schema.rb")
  require File.dirname(__FILE__) + "/../rails/init.rb"
end

require File.dirname(__FILE__)+'/models'
