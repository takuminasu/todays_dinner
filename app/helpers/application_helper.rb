module ApplicationHelper
  def periods
    { I18n.t('.menus.new.one_day') => 1, I18n.t('.menus.new.seven_days') => 7 }
  end
end
