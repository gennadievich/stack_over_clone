class VotesController < ApplicationController

  before_action :authenticate_user

  def vote_question_up
    @question       = Question.find(params[:question_id])
    @user           = current_user
    @question.votes += 1
    @question.save
    redirect_to :back
  end

  def vote_question_down
    @question   = Question.find(params[:question_id])
    @user       = current_user
    @question.votes -= 1
    @question.save
    redirect_to :back
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
