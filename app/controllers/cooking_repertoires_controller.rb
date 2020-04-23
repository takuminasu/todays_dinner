class CookingRepertoiresController < ApplicationController
  before_action :find_repertoire, only: [:show, :edit, :update, :destroy]
  before_action :list_tags, only: [:new, :create]

  def index
    @cooking_repertoires = CookingRepertoire.all
  end

  def new
    @cooking_repertoire = CookingRepertoire.new
  end

  def create
    @cooking_repertoire = CookingRepertoire.new(cooking_repertoire_params)
    
    if @cooking_repertoire.save
      redirect_to :root, notice: t('.added_repertoire', { name: @cooking_repertoire.name })
    else
      render :new
    end
  end

  def update
    if @cooking_repertoire.update(cooking_repertoire_params)
      redirect_to :root, notice: t('.edited_repertoire', { name: @cooking_repertoire.name })
    else
      render :edit
    end
  end

  def destroy
    redirect_to :root, notice: t('.deleted_repertoire', { name: @cooking_repertoire.name })
  end

  private

  def cooking_repertoire_params
    params.require(:cooking_repertoire).permit(:name, { tag_ids: [] })
  end

  def find_repertoire
    @cooking_repertoire = CookingRepertoire.find(params[:id])
  end

  def list_tags
    @tags = Tag.where.not(name: t('.erase'))
  end
end
