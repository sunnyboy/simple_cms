require File.join(RAILS_ROOT, 'lib', 'position_mover.rb')

class Page < ActiveRecord::Base
  include PositionMover

  belongs_to :subject, {:foreign_key=>"subject_id"}
  # fk subject_id nieje treba definovat. Rails to automaticky predpoklada. Pouziva sa len ak je fk iny ako predpokladany.
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"
  # Moze byt aj has_and_belongs_to_many :users
  # Ak pouzijem iny nazov, ako je nazov relacneho modelu, treba ho dodatocne definovati
  
  validates_presence_of   :name
  validates_length_of     :name, :within=>3..30
  validates_presence_of   :permalink
  validates_length_of     :permalink, :within=>3..30
  validates_uniqueness_of :permalink
  #validates_uniqueness_of :permalink, :scope=>:subject_id
  #for unique values by subject  
  
  scope :visible, where(:visible=>true)
  scope :invisible, where(:visible=>false)
  scope :sorted, order('pages.position ASC')
  
  private
  def position_scope # redefines method from module PositionMover
    "pages.subject_id = #{subject_id.to_i}" 
  end

end

