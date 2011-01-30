class Document < ActiveRecord::Base
  belongs_to :subject, :foreign_key => "id_recipient"
  belongs_to :subject, :foreign_key => "id_sender"
  
  scope :search, lambda {|query| where(["content LIKE?","%#{query}%"])}
  
end
  
