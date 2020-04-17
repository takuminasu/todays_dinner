class CookingRepertoiresController < ApplicationController
  def index
    @cooking_repertoires = CookingRepertoire.all
  end

  def new
    @cooking_repertoire = CookingRepertoire.new
  end

  def create
    @cooking_repertoire = CookingRepertoire.new(cooking_repertoire_params)

    if @cooking_repertoire.save
      redirect_to :root, notice: t('.added_repertoire', {name: @cooking_repertoire.name})
    else
      render :new
    end
  end

  def show
    @cooking_repertoire = CookingRepertoire.find(params[:id])
  end

  def edit
    @cooking_repertoire = CookingRepertoire.find(params[:id])
  end

  def update
    @cooking_repertoire = CookingRepertoire.find(params[:id])
    if @cooking_repertoire.update(cooking_repertoire_params)
      redirect_to :root, notice: t('.edited_repertoire', {name: @cooking_repertoire.name})
    else
      render :edit
    end
  end

  private

  def cooking_repertoire_params
    params.require(:cooking_repertoire).permit(:name)
  end
end
