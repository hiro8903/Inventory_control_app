class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.date :answer_on
      t.float :quantity
      t.string :note
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
