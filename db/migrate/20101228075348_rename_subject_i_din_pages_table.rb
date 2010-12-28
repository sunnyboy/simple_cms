class RenameSubjectIDinPagesTable < ActiveRecord::Migration
  def self.up
    rename_table("subjects","stories")
    rename_column("pages", "subject_id","story_id")
  end

  def self.down
    rename_table("stories","subjects")
    rename_column("pages", "story_id","subject_id")
  end
end
