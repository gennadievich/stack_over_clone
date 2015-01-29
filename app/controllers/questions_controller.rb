class QuestionsController < ApplicationController


  def index_15
    @question = Question.order('created_at desc').limit(15)
  end

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

  def search_questions_by
    @question = Tag.find(params[:tag_id]).questions
  end

  def create

    @question = Question.new(question_params)
    tags = @question.tages
    @question.tags << tags

    if @question.save
      redirect_to root_path
    else
      render :new
    end
  end


  private
  def  question_params
    params.require(:question).permit(:title, :description, :tages)
  end

end
