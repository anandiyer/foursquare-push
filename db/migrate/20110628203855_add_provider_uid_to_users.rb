class AddProviderUidToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :name, :string
  end

  def self.down
    remove_column :users, :uid
    remove_column :users, :provider
    remove_column :users, :name
  end
end