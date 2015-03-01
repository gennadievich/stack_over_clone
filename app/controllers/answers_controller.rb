class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save

    redirect_to question_path(@question)
  end

  def best_answer
    @answer   = Answer.find(params[:answer_id])
    @question = @answer.question
    @best_answer  = @question.answers.where('accepted = ?', true).count

    if @question.user == current_user
      if @answer.user != current_user
        if @best_answer == 0
          @answer.accepted = true
          @answer.save
        else
          redirect_to :back
        end
      else
        redirect_to :back
      end
    end
  end

  def not_best_answer
    @answer   = Answer.find(params[:answer_id])
    @question = @answer.question
    if @question.user == current_user
      @answer.accepted = false
      @answer.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private
  def  answer_params
    params.require(:answer).permit(:body)
  end

end
