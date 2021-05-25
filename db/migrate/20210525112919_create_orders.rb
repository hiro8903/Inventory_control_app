class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :order_on, default: Date.today
      t.float :quantity
      t.date :desired_on
      t.string :note
      t.references :paint, foreign_key: true

      t.timestamps
    end
  end
end
