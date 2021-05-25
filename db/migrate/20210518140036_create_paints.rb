class CreatePaints < ActiveRecord::Migration[5.1]
  def change
    create_table :paints do |t|
      t.string :name
      t.belongs_to :manufacturer
      t.belongs_to :supplier
      t.float :unit_price
      t.string :unit
      t.float :ordering_point

      t.timestamps
    end
  end
end
