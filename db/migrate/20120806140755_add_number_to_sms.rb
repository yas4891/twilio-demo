class AddNumberToSms < ActiveRecord::Migration
  def change
    add_column :sms, :number, :string

  end
end
