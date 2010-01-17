class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :cyrpted_password
      t.string :salt
      t.string :remember_token
      t.string :remember_token_expiration
      t.string :activation_code
      t.datetime :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
