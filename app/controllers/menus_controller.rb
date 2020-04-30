class MenusController < ApplicationController
  def index
    @menus = Menu.where('date >= ?', Date.today)
  end

  def new
    @menu = Menu.new
  end

  def create
    period = params[:menu][:frequency].to_i
    date = Date.parse(params[:menu][:date])
    Menu.create_for(period, date)
    redirect_to menus_path
  end
end
