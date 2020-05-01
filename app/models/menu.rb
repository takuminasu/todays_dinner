class Menu < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.create_for(period, date)
    to = date + period - 1
    (date..to).each do |day|
      menu = Menu.find_or_initialize_by(date: day)
      menu.update_attributes!({ cooking_repertoire_id: CookingRepertoire.random_id })
    end
  end
end
