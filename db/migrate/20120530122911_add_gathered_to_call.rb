class AddGatheredToCall < ActiveRecord::Migration
  def change
    add_column :calls, :gathered_numbers, :string

  end
end
