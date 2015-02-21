class VotesController < ApplicationController

  before_action :authenticate_user
  after_action :set_rating_for_question, only: [:vote_question_down, :vote_question_up]
  after_action :set_rating_for_answer, only: [:vote_answer_down, :vote_answer_up]

  def vote_question_up
    @question       = Question.find(params[:question_id])
    @vote           = Vote.new(vote: 'up', user_id: current_user.id)
    check_vote_up   = @question.votes.where('vote = ? and user_id = ?', 'up', current_user.id).count
    if check_vote_up == 0
      check_vote_down = @question.votes.where('vote = ? and user_id = ?', 'down', current_user.id)

      if check_vote_down.count != 0
        @question.votes.where('vote = ? and user_id = ?', 'down', current_user.id).delete_all
      end
      @question.votes << @vote
      @question.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def vote_question_down
    @question         = Question.find(params[:question_id])
    @vote             = Vote.new(vote: 'down', user_id: current_user.id)
    check_vote_down   = @question.votes.where('vote = ? and user_id = ?', 'down', current_user.id).count
    if check_vote_down == 0
      check_vote_up   = @question.votes.where('vote = ? and user_id = ?', 'up', current_user.id).count

      if check_vote_up != 0
        @question.votes.where('vote = ? and user_id = ?', 'up', current_user.id).delete_all
      end
      @question.votes << @vote
      @question.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def vote_answer_up
    @answer           = Answer.find(params[:answer_id])
    @vote             = Vote.new(vote: 'up', user_id: current_user.id)
    check_vote_up     = @answer.votes.where('vote = ? and user_id = ?', 'up', current_user.id).count
    if check_vote_up  == 0
      check_vote_down = @answer.votes.where('vote = ? and user_id = ?', 'down', current_user.id)

      if check_vote_down.count != 0
        @answer.votes.where('vote = ? and user_id = ?', 'down', current_user.id).delete_all
      end
      @answer.votes << @vote
      @answer.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def vote_answer_down
    @answer           = Answer.find(params[:answer_id])
    @vote             = Vote.new(vote: 'down', user_id: current_user.id)
    check_vote_down     = @answer.votes.where('vote = ? and user_id = ?', 'down', current_user.id).count
    if check_vote_down  == 0
      check_vote_up = @answer.votes.where('vote = ? and user_id = ?', 'up', current_user.id)

      if check_vote_up.count != 0
        @answer.votes.where('vote = ? and user_id = ?', 'up', current_user.id).delete_all
      end
      @answer.votes << @vote
      @answer.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def set_rating_for_question
    @question = Question.find(params[:question_id])
    @question.rating = @question.score
    @question.save
  end

  def set_rating_for_answer
    @answer = Answer.find(params[:answer_id])
    @answer.rating = @answer.score
    @answer.save
  end

end
