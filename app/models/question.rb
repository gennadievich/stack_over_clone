class Question < ActiveRecord::Base

  validates_presence_of :title, :description, :tags

  has_and_belongs_to_many :tags
  belongs_to :user
  has_many :answers
  has_many :votes

  def tages=(tages)
    tages = tages.split(', ').map do |tag|
      Tag.where(name: tag).first_or_create
    end
    @tages = tages
  end

  def tages
    @tages
  end

  def score
    up = votes.where('vote = ?', 'up').count
    down = votes.where('vote = ?', 'down').count
    up - down
  end


end
