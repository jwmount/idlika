class CreateItems < ActiveRecord::Migration

#CREATE TABLE `items` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`gift_id` int(11) DEFAULT NULL,
  #`registry_id` int(11) DEFAULT NULL,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :items do |t|

      t.integer   :gift_id
      t.integer   :registry_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
