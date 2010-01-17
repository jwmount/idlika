class CreateGivers < ActiveRecord::Migration
  def self.up
    create_table :givers do |t|
      t.integer :gift_id
      t.string :name
      t.text :status

      t.timestamps
    end
  end

  def self.down
    drop_table :givers
  end
end
