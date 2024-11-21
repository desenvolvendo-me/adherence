class CreateMachineProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :machine_products do |t|
      t.references :machine, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    add_index :machine_products, [:machine_id, :product_id], unique: true
  end
end