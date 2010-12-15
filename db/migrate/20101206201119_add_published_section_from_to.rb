class AddPublishedSectionFromTo < ActiveRecord::Migration
  def self.up
    add_column("sections", "published_from", :datetime, :default => "0000-00-00 00:00:00")
    add_column("sections", "published_to", :datetime, :default => "0000-00-00 00:00:00")
  end

  def self.down
    remove_column("sections", "published_from")
    remove_column("sections", "published_to")
  end
end
