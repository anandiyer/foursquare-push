class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.string :id
      t.string :venue_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
