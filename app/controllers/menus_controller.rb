class MenusController < ApplicationController
  def index
    @menus = Menu.where('date >= ?', Date.today)
  end

  def new
    @menu = Menu.new
  end

  def create
    period = params[:menu][:period].to_i
    date = Date.parse(params[:menu][:date])
    Menu.create_for(period, date)
    if params[:menu][:period] == '1'
      redirect_to menus_path, notice: t('.added_menu', { day: date })
    else
      redirect_to menus_path, notice: t('.added_menus', { start_day: date, end_day: date + period })
    end
  end
end
