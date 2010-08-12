class CreateDonors < ActiveRecord::Migration

#CREATE TABLE `donors` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`gift_id` int(11) DEFAULT NULL,
  #`allow_id` int(11) DEFAULT NULL,
  #`marker_cb` tinyint(1) NOT NULL DEFAULT '0',
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=62 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :donors do |t|
      t.integer    :gift_id
      t.integer    :allow_id
      t.boolean    :marker_cb

      t.timestamps
    end
  end

  def self.down
    drop_table :donors
  end
end
