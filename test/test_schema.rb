ActiveRecord::Schema.define(:version => 0) do
  create_table :users , :force=>true do |t|
    t.string    :login,               :null => false                # optional, you can use email instead, or both
    t.string    :email,               :null => false                # optional, you can use login instead, or both
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
  end

  create_table :groups , :force=>true do |t|
    t.string :name
    t.text :description
    t.timestamps
  end

  create_table :memberships , :force=>true do |t|
    t.integer :group_id
    t.integer :user_id
    
    t.timestamps
  end

  add_index :memberships, [:group_id,:user_id], :unique=>true

  create_table :roles , :force=>true do |t|
    t.string :name
    t.string :scope #this is the name of the class
    t.timestamps
  end

  add_index :roles, [:name,:scope], :unique=>true

  create_table :user_role_memberships , :force=>true do |t|
    t.integer :role_id
    t.integer :user_id
    t.integer :instance_id
  end

  add_index :user_role_memberships, [:role_id, :user_id, :instance_id], :unique=>true

  create_table :group_role_memberships , :force=>true do |t|
    t.integer :role_id
    t.integer :group_id
    t.integer :instance_id
  end

  add_index :group_role_memberships, [:role_id, :group_id, :instance_id], :unique=>true

  #Test case specific tables

  create_table :documents, :force=>true do |t|
    t.string :name
    t.string :description
    t.integer :section_id
    t.timestamps
  end

  create_table :sections, :force=>true do |t|
    t.string :name
    t.string :description

    t.timestamps
  end

end
