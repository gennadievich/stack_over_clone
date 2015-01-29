class TagsController < ApplicationController

  def index
    @tag = Tag.all
  end

end
