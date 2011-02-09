class Partner < ActiveRecord::Base
  has_many :senders_documents,    :class_name => 'Document', :foreign_key => 'id_sender'
  has_many :recipients_documents, :class_name => 'Document', :foreign_key => 'id_recipient'  
end
