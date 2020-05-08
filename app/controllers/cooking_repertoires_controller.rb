class CookingRepertoiresController < ApplicationController
  before_action :find_repertoire, only: [:show, :edit, :update, :destroy]

  def index
    @cooking_repertoires = CookingRepertoire.all
  end

  def new
    @cooking_repertoire = CookingRepertoire.new
    @tags = Tag.category
  end

  def create
    @cooking_repertoire = CookingRepertoire.new(cooking_repertoire_params)
    @tags = Tag.category

    if @cooking_repertoire.save
      redirect_to tags_path, notice: t('.added_repertoire', { name: @cooking_repertoire.name })
    else
      render :new
    end
  end

  def edit
    @tags = Tag.category
  end

  def update
    @tags = Tag.category

    if @cooking_repertoire.update(cooking_repertoire_params)
      redirect_to :root, notice: t('.edited_repertoire', { name: @cooking_repertoire.name })
    else
      render :edit
    end
  end

  def destroy
    redirect_to :tags, notice: t('.deleted_repertoire', { name: @cooking_repertoire.name })
  end

  private

  def cooking_repertoire_params
    params.require(:cooking_repertoire).permit(:name, { tag_ids: [] })
  end

  def find_repertoire
    @cooking_repertoire = CookingRepertoire.find(params[:id])
  end
end
