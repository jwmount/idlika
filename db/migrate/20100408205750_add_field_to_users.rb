class AddFieldToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :test, :string
  end

  def self.down
    remove_column :users, :test
  end
end
