class AddMeetingpostToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :meetingpost, :boolean, :default => false
  end
end
