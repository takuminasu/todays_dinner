class Menu < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.select_days(period, date)
    period.times do
      menu = Menu.find_or_initialize_by(date: date)
      menu.update_attributes({ date: date }.merge(cooking_repertoire_id: CookingRepertoire.random_id))
      date += 1
    end
  end
end
