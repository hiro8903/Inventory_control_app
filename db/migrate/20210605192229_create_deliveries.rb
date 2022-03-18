class CreateDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :deliveries do |t|
      t.date :delivery_on
      t.float :quantity
      t.string :lot_number
      t.boolean :invoice, default: 0
      t.integer :arrival_confirmer_id
      t.integer :invoice_confirmer_id
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
