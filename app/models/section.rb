require File.join(RAILS_ROOT, 'lib', 'position_mover.rb')

class Section < ActiveRecord::Base
  include PositionMover
  
  belongs_to :page
  has_many :section_edits
  has_many :editors, :through => :section_edits, :class_name => "AdminUser"
  
  CONTENT_TYPES=['text','HTML']   #deklarovaná konštanta
  
  validates_presence_of   :name
  validates_length_of     :name, :within=>3..30
  validates_inclusion_of  :content_type, :in=>CONTENT_TYPES,
                          :message=>"must be one of: #{CONTENT_TYPES.join(', ')}"
  validates_presence_of   :content
  
  scope :visible, where(:visible=>true)
  scope :invisible, where(:visible=>false)
  scope :sorted, order('sections.position ASC')

  private
  def position_scope # redefines method from module PositionMover
    "sections.page_id = #{page_id.to_i}" 
  end 
end
