class Menu < ApplicationRecord
  validates :date, presence: true, uniqueness: true

  belongs_to :cooking_repertoire
end
