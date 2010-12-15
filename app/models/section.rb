class Section < ActiveRecord::Base
  
  belongs_to :page
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  
  CONTENT_TYPES=['text','HTML']   #deklarovaná konštanta
  
  validates_presence_of   :name
  validates_length_of     :name, :within=>3..30
  validates_inclusion_of  :content_type, :in=>CONTENT_TYPES,
                          :message=>"must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of   :content
end
