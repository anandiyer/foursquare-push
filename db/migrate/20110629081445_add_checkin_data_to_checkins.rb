class AddCheckinDataToCheckins < ActiveRecord::Migration
  def self.up
    add_column :checkins, :data, :text
  end

  def self.down
    remove_column :checkins, :data
  end
end
