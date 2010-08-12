class CreateViewers < ActiveRecord::Migration

#CREATE TABLE `viewers` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`user_id` int(11) DEFAULT NULL,
  #`gift_id` int(11) DEFAULT NULL,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :viewers do |t|

      t.integer :user_id        #who viewer is
      t.integer :gift_id        #gift viewer can see

      t.timestamps
    end
  end

  def self.down
    drop_table :viewers
  end
end
