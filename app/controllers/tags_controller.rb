class TagsController < ApplicationController
  def index
    @tags = Tag.category
  end
end
