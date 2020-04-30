class MenusController < ApplicationController
  def index
    @menus = Menu.where('date >= ?', Date.today)
  end

  def new
    @menu = Menu.new
  end

  def create
    period = params[:menu][:period_id].to_i
    date = Date.parse(params[:menu][:date])
    Menu.select_days(period, date)
    redirect_to menus_path
  end
end
