class Machine < ApplicationRecord
  # Enums
  enum status: {
    active: 0,
    inactive: 1
  }

  # Validations
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :status, presence: true

  # Scopes
  scope :search, ->(term) {
    where("code ILIKE :term OR name ILIKE :term", term: "%#{term}%") if term.present?
  }
end