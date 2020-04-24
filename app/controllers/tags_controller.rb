class TagsController < ApplicationController
  def index
    @tags = Tag.valid
  end
end
