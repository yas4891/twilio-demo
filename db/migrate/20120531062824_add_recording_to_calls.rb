class AddRecordingToCalls < ActiveRecord::Migration
  def change
    add_column :calls, :recording_url, :string

    add_column :calls, :recording_duration, :string

  end
end
