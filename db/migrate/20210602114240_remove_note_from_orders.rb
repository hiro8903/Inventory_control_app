class RemoveNoteFromOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :note, :string
    add_column :orders, :accept, :boolean, default: false
  end
end
