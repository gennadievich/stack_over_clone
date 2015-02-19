class QuestionsController < ApplicationController

  before_action :authenticate_user, except: [:index,:index_15, :show]

  def index_15
    @question = Question.order('created_at desc').limit(15)
  end

  def sort_by_rating
    @question = Question.order('views desc')
  end

  def index
    @question = Question.order('created_at desc')
  end

  def show
    @question = Question.find(params[:id])
    @question.views+=1
    @question.save
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def search_questions_by
    @question = Tag.find(params[:tag_id]).questions
  end

  def destroy
    @question = Question.find(params[:id])

      if @question.tags.present?
        @question.tags.each do |tag|
          check_tag(tag.id)
        end
      end

    @question.destroy
    redirect_to root_path
  end

  def create

    @question = Question.new(question_params)
    tags = @question.tages
    @question.tags << tags
    @question.user = @current_user

    if @question.save
      redirect_to question_path(@question)
    else
      render :new
    end
  end


  private
  def  question_params
    params.require(:question).permit(:title, :description, :tages)
  end

  def check_tag(id)
    tag = Tag.find(id)
      if tag.questions.size == 1
        tag.delete
      end
  end

end
