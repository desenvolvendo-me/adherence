class CreateProductionPlannings < ActiveRecord::Migration[8.0]
  def change
    create_table :production_plannings do |t|
      t.date :planning_date, null: false
      t.string :shift, null: false

      t.timestamps
    end

    create_table :production_planning_items do |t|
      t.references :production_planning, null: false, foreign_key: true
      t.references :machine, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :goal, null: false

      t.timestamps
    end

    add_index :production_plannings, [:planning_date, :shift], unique: true
  end
end