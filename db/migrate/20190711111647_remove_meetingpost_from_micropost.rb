class RemoveMeetingpostFromMicropost < ActiveRecord::Migration[5.1]
  def change
    remove_column :microposts, :meetingpost, :boolean
  end
end
