class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.decimal :standard_time, null: false, precision: 10, scale: 2
      t.decimal :setup_time, null: false, precision: 10, scale: 2
      t.string :status, null: false, default: 'active'

      t.timestamps null: false

      t.index :code, unique: true
    end
  end
end