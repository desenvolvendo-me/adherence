class ProductionPlanning < ApplicationRecord
  has_many :production_planning_items, dependent: :destroy

  validates :planning_date, presence: true
  validates :shift, presence: true

  # Enums
  enum :shift, {
    first_shift: "first_shift",    # 06:00 - 14:00
    second_shift: "second_shift",  # 14:00 - 22:00
    third_shift: "third_shift"     # 22:00 - 06:00
  }

  accepts_nested_attributes_for :production_planning_items,
                                allow_destroy: true,
                                reject_if: :all_blank

  def self.ransackable_attributes(auth_object = nil)
    ["planning_date", "shift"]
  end
end