class Product < ApplicationRecord
  has_many :machine_products, dependent: :destroy
  has_many :machines, through: :machine_products

  # Enums
  enum :status, { active: 'active', inactive: 'inactive', in_development: 'in_development' }

  # Validações
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :standard_time, presence: true,
            numericality: { greater_than: 0 }
  validates :setup_time, presence: true,
            numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  # Callbacks
  before_validation :upcase_code

  accepts_nested_attributes_for :machine_products, allow_destroy: true

  private

  def upcase_code
    self.code = code.upcase if code.present?
  end

  # Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["code", "name", "status"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end