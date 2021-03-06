class Menu < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire

  def self.make(from, to, not_duplicate_day, candidate_repertoires)
    ActiveRecord::Base.transaction do
      (from..to).each { |day| make_for_one_day(not_duplicate_day, day, candidate_repertoires) }
    end
  rescue StandardError => e
    puts e.message
  end

  class << self
    private

    def make_for_one_day(not_duplicate_day, day, candidate_repertoires)
      tags = exclude_tags(not_duplicate_day, day)
      exclude_repertoire = CookingRepertoire.joins(:tags).where(tags: { id: tags })
      cooking_repertoire_id = candidate_repertoires.where.not(id: exclude_repertoire).sample.id
      menu = Menu.find_or_initialize_by(date: day)
      menu.update_attributes!({ cooking_repertoire_id: cooking_repertoire_id })
    end

    def exclude_tags(not_duplicate_day, day)
      tags = []
      (1..not_duplicate_day).each do |i|
        before_day = day - i
        before_menu = Menu.find_by(date: before_day)
        next if before_menu.nil?

        cooking_repertoire_id = before_menu.cooking_repertoire_id
        tag = CookingRepertoire.find(cooking_repertoire_id).tags
        tags += tag
      end
      tags
    end
  end
end
