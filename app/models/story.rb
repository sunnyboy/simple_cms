require File.join(RAILS_ROOT, 'lib', 'position_mover.rb')

class Story < ActiveRecord::Base
  include PositionMover
  has_many :pages
  
  validates_presence_of :name
  validates_length_of   :name, :minimum=>3, :maximum=>255
  
  scope :visible, where(:visible=>true)
  scope :invisible, where(:visible=>false)
  scope :sorted, order('stories.position ASC')
  scope :search, lambda {|query| where(["name LIKE?","%#{query}%"])}
 
  # Tu moze byt aplikovany plugin Thinking Sphinx /epizoda 120 Railscasts/ , ktory zabezpeci full text vyhladavanie
  
  def self.search(search)
    # Tato funkcia duplicitne prepisuje scope search, ktory uz zuzenie scope na zaklade query riesi
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped   
      # mozne pouzit aj all- avsak scoped nastavi prazdny scope/ nerobi query do databazy= rychlejsie
      # all by vratilo pole zaznamov. scoped vrati prazdny scope na ktorom sa daju robit dalsie queries.
    end
  end
end
