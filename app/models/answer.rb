class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :votes


  def score
    up = votes.where('vote = ?', 'up').count
    down = votes.where('vote = ?', 'down').count
    up - down
  end

end
