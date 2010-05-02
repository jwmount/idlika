class RemoveIdFromRoles < ActiveRecord::Migration
  def self.up
  end

  def self.down
    remove_column :roles, :id
  end
end
