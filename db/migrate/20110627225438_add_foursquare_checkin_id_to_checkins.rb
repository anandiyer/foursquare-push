class AddFoursquareCheckinIdToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :checkin_id, :string
  end

  def self.down
    remove_column :checkins, :checkin_id
  end
end
