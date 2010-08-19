class CreateGifts < ActiveRecord::Migration

#CREATE TABLE `gifts` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`user_id` int(11) DEFAULT NULL,
  #`registry_id` int(11) DEFAULT NULL,
  #`name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`source` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`URL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`i_can_see` tinyint(1) NOT NULL DEFAULT '1',
  #`friends_can_see` tinyint(1) NOT NULL DEFAULT '0',
  #`who_can_see` text COLLATE utf8_unicode_ci,
  #`photo_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`photo_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`photo_file_size` int(11) DEFAULT NULL,
  #`photo_updated_at` datetime DEFAULT NULL,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :gifts do |t|
      t.integer :user_id,           :null => false
      t.integer :registry_id,       :null => false
      t.string  :name,              :null => false
      t.string  :source
      t.string  :description,       :null => false, :default => ''
      t.string  :URL,               :null => false, :default => ''
      t.boolean :i_can_see,         :null => false, :default => true
      t.boolean :friends_can_see,   :null => false, :default => false
      t.text    :who_can_see,       :null => false, :default => ''
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
