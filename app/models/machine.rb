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
  validate :validate_code_format

  # Scopes
  scope :search, ->(term) {
    where("code ILIKE :term OR name ILIKE :term", term: "%#{term}%") if term.present?
  }

  private

  def validate_code_format
    unless code.match?(/\A[A-Z][a-z]{2}\d{3}\z/)
      errors.add(:code, "deve seguir o formato. Ex: Cen006, Dob020")
    end
  end
end