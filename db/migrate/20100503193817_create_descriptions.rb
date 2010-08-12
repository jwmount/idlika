class CreateDescriptions < ActiveRecord::Migration

#CREATE TABLE `descriptions` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`gift_id` int(11) DEFAULT NULL,
  #`description` text COLLATE utf8_unicode_ci,
  #`image_url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :descriptions do |t|

      t.integer :gift_id
      t.text    :description
      t.text    :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
