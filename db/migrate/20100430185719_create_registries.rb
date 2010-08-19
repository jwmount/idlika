class CreateRegistries < ActiveRecord::Migration

#CREATE TABLE `registries` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`user_id` int(11) DEFAULT NULL,
  #`name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #`description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :registries do |t|

      t.integer :user_id,     :null => false      # Member who 'owns' this registry
      t.string  :name,        :null => false, :default => 'Recently Added'
      t.string  :description, :null => false, :default => ''

      t.timestamps
    end
  end

  def self.down
    drop_table :registries
  end
end
