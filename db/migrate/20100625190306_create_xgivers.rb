class CreateXgivers < ActiveRecord::Migration

#CREATE TABLE `Xgivers` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`gift_id` int(11) DEFAULT NULL,
  #`name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`status` text COLLATE utf8_unicode_ci,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :Xgivers do |t|

      t.integer   :gift_id
      t.string    :name
      t.string    :status

      t.timestamps
    end
  end

  def self.down
    drop_table :Xgivers
  end
end
