class TagsController < ApplicationController
  def index
    @tags = Tag.where.not(name: t('.erase'))
  end
end
