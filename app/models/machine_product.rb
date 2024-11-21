class MachineProduct < ApplicationRecord
  belongs_to :machine
  belongs_to :product

  validates :machine_id, presence: true
  validates :machine_id, uniqueness: {
    scope: :product_id,
    message: "já está vinculada a este produto"
  }
end