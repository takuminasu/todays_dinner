class MenusController < ApplicationController
  def index
    @menus = Menu.all
  end
  def new
    @menu = Menu.new
  end

  def create
    7.times do |i|
      @menu = Menu.new(menu_params.merge(cooking_repertoire_id: CookingRepertoire.random_id))
      puts i
      if 0 < i
        @menu.date += i
      end
      @menu.save
    end
    redirect_to menus_path
  end

  def show
    @menu = Menu.find_by(date: Date.today)
  end

  private

  def menu_params
    params.require(:menu).permit(:date)
  end
end
