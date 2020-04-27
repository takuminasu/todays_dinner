class MenusController < ApplicationController
  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params.merge(cooking_repertoire_id: CookingRepertoire.random_id))

    if @menu.save
      redirect_to menu_path(@menu)
    else
      render :new
    end
  end

  def show
    @menu = Menu.find_by(date: Date.today)
  end

  private

  def menu_params
    params.require(:menu).permit(:date)
  end
end
