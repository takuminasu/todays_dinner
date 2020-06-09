class MenusController < ApplicationController
  before_action :initialize_menu_params, only: [:create]
  before_action :save_menu_candidate_tags, only: [:create]

  def index
    @menus = Menu.where('date >= ?', Date.today).order(:date)
  end

  def new
    @menu = Menu.new
    @tags = Tag.category
  end

  def create
    repertoire_candidates
    if Menu.make(@from_date, @to_date, @not_duplicate_day, @repertoire_candidates)
      redirect_to menus_path, notice: added_message(@from_date, @to_date)
    else
      redirect_to new_menu_path, notice: t('.creation_failed')
    end
  end

  private

  def initialize_menu_params
    @period = params[:menu][:period].to_i
    @date = params[:menu][:date]
    check_if_the_date_is_valid
    @not_duplicate_day = params[:menu][:not_duplicate_day].to_i
  end

  def check_if_the_date_is_valid
    if @date.blank?
      redirect_to new_menu_path, notice: t('.creation_failedon_start_date')
    else
      @from_date = Date.parse(@date)
      @to_date = @from_date + @period - 1
    end
  end

  def save_menu_candidate_tags
    @tag_candidates = params[:tag_candidates]
    if @tag_candidates.nil?
      redirect_to new_menu_path, notice: t('.tag_candidate_nil')
    else
      MenuCandidateTag.make(@tag_candidates[:tags])
    end
  end

  def added_message(from_date, to_date)
    if from_date == to_date
      t('.added_menu', { day: l(from_date) })
    else
      t('.added_menus', { start_day: l(from_date), end_day: l(to_date) })
    end
  end

  def repertoire_candidates
    candidate_tags = Tag.joins(:menu_candidate_tag)
    exclude_tags = Tag.where.not(id: candidate_tags)
    exclude_repertoires = CookingRepertoire.joins(:tags).where(tags: { id: exclude_tags })
    @repertoire_candidates = CookingRepertoire.where.not(id: exclude_repertoires)
  end
end
