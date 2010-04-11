class AddAcceptedCbToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :terms_accepted_cb,  :integer
  end

  def self.down
  end
end
