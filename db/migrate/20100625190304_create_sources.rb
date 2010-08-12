class CreateSources < ActiveRecord::Migration

#CREATE TABLE `sources` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`gift_id` int(11) DEFAULT NULL,
  #`user_id` int(11) DEFAULT NULL,
  #`claim_cb` tinyint(1) NOT NULL DEFAULT '0',
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :sources do |t|

      t.integer   :gift_id
      t.integer   :user_id
      t.boolean   :claim_cb        # true? user has commited to provide gift
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
