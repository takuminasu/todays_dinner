class CookingRepertoiresController < ApplicationController
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

  private

  def cooking_repertoire_params
    params.require(:cooking_repertoire).permit(:name)
  end
end
