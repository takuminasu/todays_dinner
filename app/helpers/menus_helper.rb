module MenusHelper
  def periods
    { I18n.t('.menus.new.one_day') => 1, I18n.t('.menus.new.seven_days') => 7, I18n.t('.menus.new.thirty_days') => 30 }
  end

  def not_duplicate_days
    @not_duplicate_days = {}
    tags = []
    (1..7).each do |i|
      tags += before_tags(i)
      exclude_repertoire = CookingRepertoire.joins(:tags).where(tags: { id: tags })
      cooking_repertoie = CookingRepertoire.valid.where.not(id: exclude_repertoire)
      break if cooking_repertoie.empty?

      @not_duplicate_days[I18n.t('.menus.new.day', one_day: i)] = i
    end
    @not_duplicate_days
  end

  def before_tags(num)
    before_day = Date.today - num
    before_menu = Menu.find_by(date: before_day)
    cook_id = before_menu[:cooking_repertoire_id]
    CookingRepertoire.find(cook_id).tags
  end
end
