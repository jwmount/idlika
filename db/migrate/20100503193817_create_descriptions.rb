class CreateDescriptions < ActiveRecord::Migration
  def self.up
    create_table :descriptions do |t|

      t.integer :gift_id
      t.text    :description
      
      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
