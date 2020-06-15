module MenusHelper
  def periods
    { I18n.t('.menus.new.one_day') => 1, I18n.t('.menus.new.seven_days') => 7, I18n.t('.menus.new.thirty_days') => 30 }
  end

  def not_duplicate_days
    not_duplicate_days = {}
    tags = []
    (1..7).each do |i|
      tags += before_tags(i)
      exclude_repertoire = CookingRepertoire.joins(:tags).where(tags: { id: tags })
      cooking_repertoire = CookingRepertoire.valid.where.not(id: exclude_repertoire)
      make_not_duplicate_days(cooking_repertoire, not_duplicate_days, i)
    end
    not_duplicate_days
  end

  def before_tags(num)
    before_day = Date.today - num
    before_menu = Menu.find_by(date: before_day)
    return [] if before_menu.nil?

    cooking_repertoire_id = before_menu.cooking_repertoire_id
    CookingRepertoire.find(cooking_repertoire_id).tags
  end

  def make_not_duplicate_days(cooking_repertoire, not_duplicate_days, num)
    if cooking_repertoire.empty? && num == 1
      not_duplicate_days[I18n.t('.menus.new.day', one_day: 0)] = 0
    elsif cooking_repertoire.empty?
    else
      not_duplicate_days[I18n.t('.menus.new.day', one_day: num)] = num
    end
  end
end
