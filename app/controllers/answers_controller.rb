class AnswersController < ApplicationController

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.save

    redirect_to question_path(@question)
  end


  private
  def  answer_params
    params.require(:answer).permit(:body)
  end

end
