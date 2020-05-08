class CookingRepertoireTagsController < ApplicationController
  def create
    cooking_repertoire_and_tag
    cooking_repertoire_tag = CookingRepertoireTag.new(cooking_repertoire_id: @cooking_repertoire.id, tag_id: @tag.id)
    if cooking_repertoire_tag.save
      redirect_to tags_path, notice: t('.deleted_repertoire', { name: @cooking_repertoire.name })
    else
      redirect_to cooking_repertoire_path(@cooking_repertoire), notice: t('.failed_delete')
    end
  end

  private

  def cooking_repertoire_and_tag
    @cooking_repertoire = CookingRepertoire.find(params[:format])
    @tag = Tag.find_by(name: Tag.human_attribute_name(:delete))
  end
end
