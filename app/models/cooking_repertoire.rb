class CookingRepertoire < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :cooking_repertoire_tags
  has_many :tags, through: :cooking_repertoire_tags
  accepts_nested_attributes_for :cooking_repertoire_tags
end
