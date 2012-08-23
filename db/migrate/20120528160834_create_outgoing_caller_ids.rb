class CreateOutgoingCallerIds < ActiveRecord::Migration
  def change
    create_table :outgoing_caller_ids do |t|
      t.string :status
      t.string :validation_code
      t.string :sid
      t.string :phone_number
      t.string :friendly_name
      t.timestamps
    end
  end
end
