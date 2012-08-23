class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :to
      t.string :template
      t.string :sid
      

      t.timestamps
    end
  end
end
