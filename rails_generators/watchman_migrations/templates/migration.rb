class CreateWatchmanTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :email,               :null => false                # optional, you can use email instead, or both
      t.string    :username,               :null => false                # optional, you can use login instead, or both
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :single_access_token, :null => false                # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability
      # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
      t.integer   :login_count,         :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.integer   :failed_login_count,  :null => false, :default => 0 # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_request_at                                    # optional, see Authlogic::Session::MagicColumns
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :current_login_ip                                   # optional, see Authlogic::Session::MagicColumns
      t.string    :last_login_ip                                      # optional, see Authlogic::Session::MagicColumns
      t.string    :first_name
      t.string    :last_name
    end

    create_table :groups do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    create_table :memberships do |t|
      t.integer :group_id
      t.integer :user_id
      
      t.timestamps
    end

    add_index :memberships, [:group_id,:user_id], :unique=>true

    create_table :roles do |t|
      t.string :name
      t.string :scope #this is the name of the class
      t.integer :instance_id
      t.timestamps
    end

    add_index :roles, [:name,:scope,:instance_id], :unique=>true

    create_table :user_role_memberships do |t|
      t.integer :role_id
      t.integer :user_id
    end

    add_index :user_role_memberships, [:role_id, :user_id], :unique=>true

    create_table :group_role_memberships do |t|
      t.integer :role_id
      t.integer :group_id
    end

    add_index :group_role_memberships, [:role_id, :group_id], :unique=>true
  end

  def self.down
    drop_table :users
    drop_table :groups
    drop_table :roles
    drop_table :memberships
    drop_table :user_role_memberships
    drop_table :group_role_memberships
  end

end
