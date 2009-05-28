require File.dirname(__FILE__) + '/test_helper.rb' 
require 'rails_generator' 
require 'rails_generator/scripts/generate' 

class MigrationGeneratorTest < Test::Unit::TestCase 
  def setup 
    FileUtils.mkdir_p(fake_rails_root)  
    @original_files = file_list 
  end  
  def teardown 
    FileUtils.rm_r(fake_rails_root)  
  end  
  def test_generates_migration 
    Rails::Generator::Scripts::Generate.new.run(["watchman_migration"], 
                                                :destination => fake_rails_root)
    new_file = (file_list - @original_files).first
    assert /create_watchman_tables/=~new_file 
  end
  
  
  private 
  
  def fake_rails_root 
    File.join(File.dirname(__FILE__), 'rails_root')  
  end  
  def file_list 
    Dir.glob(File.join(fake_rails_root, "db", "migrate", "*"))  
  end 
end  
