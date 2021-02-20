class AddChannelToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :channel, :string
    add_column :teams, :channel_id, :string
  end
end
