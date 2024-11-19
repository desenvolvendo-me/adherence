class CreateMachines < ActiveRecord::Migration[7.2]
  def change
    create_table :machines do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
      t.index :code, unique: true
    end
  end
end