class AddBooking < ActiveRecord::Migration
  def self.up
    add_column("documents","booking",:string)
  end

  def self.down
    remove_column("documents","booking")
  end
end
