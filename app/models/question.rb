class Question < ActiveRecord::Base

  validates_presence_of :title, :description

  has_and_belongs_to_many :tags
  belongs_to :user

  def tages=(tages)
    tages = tages.split(', ').map do |tag|
      Tag.find_or_create_by_name(tag)
    end
    @tages = tages
  end

  def tages
    @tages
  end


end
