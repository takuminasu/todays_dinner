class MenusController < ApplicationController
  def index
    @menus = Menu.where('date >= ?', Date.today).order(:date)
  end

  def new
    @menu = Menu.new
  end

  def create
    period = params[:menu][:period].to_i
    from_date = Date.parse(params[:menu][:date])
    to_date = from_date + period - 1
    Menu.make(from_date, to_date)
    redirect_to menus_path, notice: added_message(from_date, to_date)
  end

  private

  def added_message(from_date, to_date)
    if from_date == to_date
      t('.added_menu', { day: from_date })
    else
      t('.added_menus', { start_day: from_date, end_day: to_date })
    end
  end
end
