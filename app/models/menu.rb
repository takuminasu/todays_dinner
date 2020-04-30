class Menu < ApplicationRecord
  enum frequency: { '1日' => 1, '7日' => 7 }
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.create_for(period, date)
    to = date + period
    (date..to).each do
      menu = Menu.find_or_initialize_by(date: date)
      menu.update_attributes({ date: date }.merge(cooking_repertoire_id: CookingRepertoire.random_id))
    end
  end
end
