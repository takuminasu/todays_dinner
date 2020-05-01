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
    if Menu.create_for(period, date)
      redirect_to menus_path
    else
      render :new
    end
  end
end
