class CreateRoles < ActiveRecord::Migration

#CREATE TABLE `roles` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :roles
  end
end
