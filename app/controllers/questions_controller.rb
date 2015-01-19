class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create

    @question = Question.new(question_params)

    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end

  def index
    @question = Question.all
  end

  private
  def  question_params
    params.require(:question).permit(:title, :description)
  end

end
