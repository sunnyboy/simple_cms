class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.references :subject
      # references automaticky vytvori foreign key subject_id a indexuje ho ???
      t.string "name"
      t.string "permalink"
      t.integer "position"
      t.boolean "visible", :default => false
      t.timestamps
    end
    add_index("pages", "permalink")
    add_index("pages", "subject_id")
  end

  def self.down
    drop_table :pages
  end
end
