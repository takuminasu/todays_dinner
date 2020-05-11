class CookingRepertoire < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :tag_size_limit

  has_many :cooking_repertoire_tags
  has_many :tags, through: :cooking_repertoire_tags
  accepts_nested_attributes_for :cooking_repertoire_tags
  has_many :menus

  scope :deleted, -> { joins(:tags).where(tags: { name: Tag.human_attribute_name(:delete) }) }
  scope :valid, -> { where.not(id: CookingRepertoire.deleted) }
  scope :random_id, -> { CookingRepertoire.valid.sample.id }

  private

  def tag_size_limit
    if cooking_repertoire_tags.empty?
      errors.add(:base, I18n.t('activerecord.errors.messages.no_select'))
    elsif cooking_repertoire_tags.size > 3
      errors.add(:base, I18n.t('activerecord.errors.messages.more_than_3'))
    end
  end
end
