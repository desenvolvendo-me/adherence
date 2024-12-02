class Machine < ApplicationRecord
  has_many :machine_products, dependent: :destroy
  has_many :products, through: :machine_products

  # Enums
  enum :status, { active: 0, inactive: 1 }

  # Validations
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :status, presence: true
  validate :validate_code_format

  def self.ransackable_attributes(auth_object = nil)
    ["code", "name", "status"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["machine_products", "products"]
  end

  private

  def validate_code_format
    unless code.match?(/\A[A-Z][a-z]{2}\d{3}\z/)
      errors.add(:code, "deve seguir o formato. Ex: Cen006, Dob020")
    end
  end
end