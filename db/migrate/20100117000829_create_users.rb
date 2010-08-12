class CreateUsers < ActiveRecord::Migration

#CREATE TABLE `users` (
  #`id` int(11) NOT NULL AUTO_INCREMENT,
  #`friend_id` int(11) DEFAULT NULL,
  #`friends` text COLLATE utf8_unicode_ci NOT NULL,
  #`role_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #`username` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  #`email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  #`terms_accepted_cb` tinyint(1) NOT NULL DEFAULT '0',
  #`crypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  #`password_salt` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  #`persistence_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  #`created_at` datetime DEFAULT NULL,
  #`updated_at` datetime DEFAULT NULL,
  #PRIMARY KEY (`id`)
#) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

  def self.up
    create_table :users do |t|
      t.integer :friend_id
      t.text    :friends
      t.string  :role_id
      t.string :username
      t.string :email
      t.boolean :terms_accepted_cb
      t.string :cyrpted_password
      t.string :password_salt
      t.string :persistence_token

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
