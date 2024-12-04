class ProductionPlanningItem < ApplicationRecord
  belongs_to :production_planning
  belongs_to :machine
  belongs_to :product

  validates :goal, presence: true,
            numericality: { greater_than: 0, only_integer: true }
  validates :machine_id, presence: true
  validates :product_id, presence: true
  validate :product_machine_compatibility

  private

  def product_machine_compatibility
    return unless machine_id.present? && product_id.present?

    unless machine.products.include?(product)
      errors.add(:product_id, "não pode ser produzido nesta máquina")
    end
  end
end