class AddCostsToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :price, :string
    add_column :calls, :status, :string

  end
end
