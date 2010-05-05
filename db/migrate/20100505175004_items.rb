class Items < ActiveRecord::Migration
  def self.up
    create_table :items do |t|

      t.integer :gift_id
      t.integer :registry_id
    
      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
