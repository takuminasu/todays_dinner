class CookingRepertoire < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validate :tag_number_limit_validation

  has_many :cooking_repertoire_tags
  has_many :tags, through: :cooking_repertoire_tags
  accepts_nested_attributes_for :cooking_repertoire_tags
  has_many :menus

  scope :random_id, -> { offset(rand(CookingRepertoire.count)).first.id }

  private

  def tag_number_limit_validation
    if cooking_repertoire_tags.empty?
      errors.add(:base, I18n.t('activerecord.errors.messages.no_select'))
    elsif cooking_repertoire_tags.size > 3
      errors.add(:base, I18n.t('activerecord.errors.messages.more_than_3'))
    end
  end
end
