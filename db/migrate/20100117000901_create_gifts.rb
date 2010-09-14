class CreateGifts < ActiveRecord::Migration


  def self.up
    create_table :gifts do |t|
      t.integer :user_id,           :null => false
      t.integer :registry_id
      t.string  :name,              :null => false
      t.string  :source
      t.string  :description,       :null => false, :default => ''
      t.string  :URL,               :null => false, :default => ''
      t.boolean :i_can_see,         :null => false, :default => true
      t.boolean :friends_can_see,   :null => false, :default => false
      t.text    :who_can_see
      t.string  :photo_file_name
      t.string  :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :gifts
  end
end
