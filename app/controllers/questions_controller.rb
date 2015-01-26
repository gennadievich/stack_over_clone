class QuestionsController < ApplicationController


  def index
    @question = Question.order('created_at desc')
  end

  def show
    @question = Question.find(params[:id])
    @question.views+=1
    @question.save
  end

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


  private
  def  question_params
    params.require(:question).permit(:title, :description)
  end

end
