class MenusController < ApplicationController
  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new
  end

  def create
    case params['menu']['period_id']
    when '1'
      one_day
    when '2'
      one_week
    end
  end

  def show
    @menu = Menu.find_by(date: Date.today)
  end

  private

  def menu_params
    params.require(:menu).permit(:date)
  end

  def one_day
    menu = Menu.find_or_initialize_by(menu_params)
    menu.update_attributes(menu_params.merge(cooking_repertoire_id: CookingRepertoire.random_id))
    redirect_to menu_path(menu)
  end

  def one_week
    7.times do |i|
      date = (Date.parse(params['menu']['date']) + i).strftime
      menu = Menu.find_or_initialize_by(date: date)
      menu.update_attributes({ date: date }.merge(cooking_repertoire_id: CookingRepertoire.random_id))
    end
    redirect_to menus_path
  end
end
