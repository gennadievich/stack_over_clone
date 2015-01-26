class Question < ActiveRecord::Base

  validates_presence_of :title, :description

  has_and_belongs_to_many :tags

end
