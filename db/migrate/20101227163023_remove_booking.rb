class RemoveBooking < ActiveRecord::Migration
  def self.up
    remove_column("documents", "booking?")
  end

  def self.down
    add_column("documents", "booking?", :string)
  end
end
