class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.integer :giver_id
      t.string :name
      t.string :supplier
      t.string :description
      t.text :image
      t.text :tags
      t.text :audience
      t.datetime :by_when
      t.datetime :after_when
      t.string :for_my
      t.datetime :deleted

      t.timestamps
    end
  end

  def self.down
    drop_table :gifts
  end
end
