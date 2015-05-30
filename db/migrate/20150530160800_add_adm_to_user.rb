class AddAdmToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :adm, :boolean
  end

  def self.down
    remove_column :users, :adm
  end
end
