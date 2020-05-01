class Menu < ApplicationRecord
  enum period: { human_attribute_name('period.one_day') => 1, human_attribute_name('period.seven_days') => 7 }
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.create_for(period, date)
    to = date + period - 1
    (date..to).each do
      menu = Menu.find_or_initialize_by(date: date)
      menu.update_attributes({ date: date, cooking_repertoire_id: CookingRepertoire.random_id })
    end
  end
end
