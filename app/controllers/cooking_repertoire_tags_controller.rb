class CookingRepertoireTagsController < ApplicationController
  def create
    find_cooking_repertoire_tags
    cooking_repertoire_tag = CookingRepertoireTag.new(cooking_repertoire_id: @cooking_repertoire.id, tag_id: @tag.id)
    cooking_repertoire_tag.save
    redirect_to tags_path, notice: t('.deleted_repertoire', { name: @cooking_repertoire.name })
  end

  private

  def find_cooking_repertoire_tags
    @cooking_repertoire = CookingRepertoire.find(params[:format])
    @tag = Tag.find_by(name: Tag.human_attribute_name(:delete))
  end
end
