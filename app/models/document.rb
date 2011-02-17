class Document < ActiveRecord::Base
  
  belongs_to :sender,       :class_name => 'Partner', :foreign_key => "id_sender"
  belongs_to :recipient,    :class_name => 'Partner', :foreign_key => "id_recipient"
  belongs_to :payer,        :class_name => 'Partner', :foreign_key => "id_payer"
  belongs_to :beneficiary,  :class_name => 'Partner', :foreign_key => "id_beneficiary"
  
  
  belongs_to :project, :foreign_key => "id_doctype"
  belongs_to :doctype, :foreign_key => "id_projectw"
  
  scope :search, lambda {|query| where(["content LIKE?","%#{query}%"])}

end
  
