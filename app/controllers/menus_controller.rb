class MenusController < ApplicationController
  before_action :initialize_menu_params, only: [:create]
  def index
    @menus = Menu.where('date >= ?', Date.today).order(:date)
  end

  def new
    @menu = Menu.new
  end

  def create
    if Menu.make(@from_date, @to_date, @not_duplicate_day)
      redirect_to menus_path, notice: added_message(@from_date, @to_date)
    else
      redirect_to new_menu_path, notice: t('.creation_failed')
    end
  end

  private

  def initialize_menu_params
    period = params[:menu][:period].to_i
    @from_date = Date.parse(params[:menu][:date])
    @to_date = @from_date + period - 1
    @not_duplicate_day = params[:menu][:not_duplicate_day].to_i
  end

  def added_message(from_date, to_date)
    if from_date == to_date
      t('.added_menu', { day: l(from_date) })
    else
      t('.added_menus', { start_day: l(from_date), end_day: l(to_date) })
    end
  end
end
