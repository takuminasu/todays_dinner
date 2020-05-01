class Menu < ApplicationRecord
  enum period: { I18n.t('activerecord.attributes.menu.period.one_day') => 1,
                 I18n.t('activerecord.attributes.menu.period.seven_days') => 7 }
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.create_for(period, date)
    to = date + period - 1
    (date..to).each do |day|
      transaction do
        menu = Menu.find_or_initialize_by(date: day)
        menu.update_attributes!({ date: day, cooking_repertoire_id: CookingRepertoire.random_id })
      end
    end
  end
end
