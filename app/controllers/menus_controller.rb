class MenusController < ApplicationController
  def index
    @menus = Menu.all
  end
  def new
    @menu = Menu.new
  end

  def create
    case params["menu"]["period_id"]
    when "1" then
      @menu = Menu.new(menu_params.merge(cooking_repertoire_id: CookingRepertoire.random_id))
      if @menu.save
        redirect_to menu_path(@menu)
      else
        render :new
      end
    when "2" then
      7.times do |i|
        @menu = Menu.new(menu_params.merge(cooking_repertoire_id: CookingRepertoire.random_id))
        @menu.date += i
        @menu.save
      end
      redirect_to menus_path
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
