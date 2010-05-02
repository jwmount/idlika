class CreateRegistries < ActiveRecord::Migration
  def self.up
    create_table :registries do |t|

      t.integer :user_id      #member who 'owns' this registry
      t.string  :name
      t.integer :gifts_count

      t.timestamps
    end
  end

  def self.down
    drop_table :registries
  end
end
