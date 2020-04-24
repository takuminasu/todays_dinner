class Tag < ApplicationRecord
  has_many :cooking_repertoire_tags
  has_many :cooking_repertoires, through: :cooking_repertoire_tags

  scope :valid, -> { where.not(name: I18n.t('activerecord.attributes.tag.delete')) }
end
