class AddOauthTokenToTeam < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :oauth_token, :string
  end
end
