class Menu < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.make(from, to, not_duplicate)
    ActiveRecord::Base.transaction do
      (from..to).each { |day| one_day(not_duplicate, day) }
    end
  rescue StandardError => e
    puts e.message
  end

  def self.one_day(not_duplicate, day)
    tags = exclude_tags(not_duplicate, day)
    exclude_repertoire = CookingRepertoire.joins(:tags).where(tags: { id: tags })
    cooking_repertoire_id = CookingRepertoire.valid.where.not(id: exclude_repertoire).sample.id
    menu = Menu.find_or_initialize_by(date: day)
    menu.update_attributes!({ cooking_repertoire_id: cooking_repertoire_id })
  end

  def self.exclude_tags(not_duplicate, day)
    tags = []
    (1..not_duplicate).each do |i|
      before_day = day - i
      before_menu = Menu.find_by(date: before_day)
      cook_id = before_menu[:cooking_repertoire_id]
      tag = CookingRepertoire.find(cook_id).tags
      tags += tag
    end
    tags
  end
end
