class CreateSources < ActiveRecord::Migration
  def self.up
    create_table :sources do |t|

      t.integer   :gift_id
      t.integer   :user_id
      t.integer   :claim_cb        # true? user has commited to provide gift
      t.timestamps
    end
  end

  def self.down
    drop_table :sources
  end
end
