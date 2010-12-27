class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.integer :id_group
      t.integer :id_company
      t.integer :id_sender
      t.integer :id_recipient
      t.integer :id_payer
      t.integer :id_beneficiary
      t.integer :id_project
      t.integer :id_doctype
      t.string :filepath
      t.string :filename
      t.string :filename_original
      t.string :db_link
      t.integer :size
      t.string :localpath
      t.time :doctime
      t.date :docdate
      t.date :docdate_paid
      t.date :doctade_delivered
      t.float :ammount_brutto
      t.float :ammount_netto
      t.float :ammount_vat
      t.string :ammount_currency
      t.string :bookedunder
      t.integer :booking?
      t.string :content
      t.string :notepublic
      t.string :noteprivat
      t.string :reference
      t.string :flags
      t.integer :selected

      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
