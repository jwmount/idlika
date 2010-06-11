class CreateViewers < ActiveRecord::Migration
  def self.up
    create_table :viewers do |t|

      t.integer :user_id        #who viewer is
      t.integer :gift_id        #gift viewer can see
      
      t.timestamps
    end
  end

  def self.down
    drop_table :viewers
  end
end
