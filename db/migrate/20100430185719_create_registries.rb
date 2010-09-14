class CreateRegistries < ActiveRecord::Migration

  def self.up
    create_table :registries do |t|

      t.integer :user_id,     :null => false      # Member who 'owns' this registry
      t.string  :name,        :null => false, :default => ''
      t.string  :description,                 :default => ''

      t.timestamps
    end
  end

  def self.down
    drop_table :registries
  end
end
