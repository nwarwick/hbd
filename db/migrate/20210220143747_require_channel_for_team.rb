class RequireChannelForTeam < ActiveRecord::Migration[5.2]
  def change
    change_column_null :teams, :channel, false
    change_column_null :teams, :channel_id, false
  end
end
