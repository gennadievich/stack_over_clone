class VotesController < ApplicationController

  before_action :authenticate_user

  def vote_question_up
    @question       = Question.find(params[:question_id])
    @vote           = Vote.new(vote: 'up', user_id: current_user.id)
    check_vote_up   = @question.votes.where('vote = ? and user_id = ?', 'up', current_user.id).count
    if check_vote_up == 0


      check_vote_down = @question.votes.where('vote = ? and user_id = ?', 'down', current_user.id)
      #raise check_vote_down.count.inspect
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
    @answer = Answer.find(params[:answer_id])

    if @answer.user == current_user
      @answer.votes -=1
    end

    @answer.votes += 1
    @answer.save
    redirect_to :back
  end

  def vote_answer_down
    @answer = Answer.find(params[:answer_id])

    if @answer.user == current_user
      @answer.votes +=1
    end

    @answer.votes -= 1
    @answer.save
    redirect_to :back
  end

end
