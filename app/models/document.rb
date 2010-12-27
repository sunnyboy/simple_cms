class Document < ActiveRecord::Base
  scope :search, lambda {|query| where(["content LIKE?","%#{query}%"])}
end
