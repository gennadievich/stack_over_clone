class VotesController < ApplicationController

  before_action :authenticate_user

  def vote_up
    @question       = Question.find(params[:question_id])
    @user           = current_user
    @question.votes += 1
    @question.save
    redirect_to :back
  end

  def vote_down
    @question   = Question.find(params[:question_id])
    @user       = current_user
    @question.votes -= 1
    @question.save
    redirect_to :back
  end

  private



end
