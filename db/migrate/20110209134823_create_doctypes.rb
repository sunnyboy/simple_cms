class CreateDoctypes < ActiveRecord::Migration
  def self.up
    create_table :doctypes do |t|
      t.string :code
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :doctypes
  end
end
