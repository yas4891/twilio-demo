class AddTranscribeToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :transcription_text, :string
    add_column :calls, :transcription_status, :string

  end
end
