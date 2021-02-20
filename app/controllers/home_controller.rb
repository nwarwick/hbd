class HomeController < ApplicationController
  def index
    authorize if params[:code]
  end

  def install
    code = params[:code]
    client = Slack::Web::Client.new(token: ENV['SLACK_BOT_TOKEN'])
    response =
      client.oauth_v2_access(
        {
          code: code,
          client_id: ENV['CLIENT_ID'],
          client_secret: ENV['CLIENT_SECRET']
        }
      )
    handle_team_creation(response)
    flash[:notice] = 'Successfully installed!'
  rescue StandardError => e
    puts "Something went wrong: #{e}"
    flash[:notice] = 'Something went wrong :('
  end

  private

  def handle_team_creation(json)
    team_json = json['team']
    team_slack_id = team_json['id']
    team_name = team_json['name']
    team_oauth_token = json['access_token']
    channel = json['incoming_webhook']['channel']
    channel_id = json['incoming_webhook']['channel_id']
    team = Team.find_by_slack_id(team_slack_id)

    if team.blank?
      # Create new team
      team =
        Team.create!(
          slack_id: team_slack_id,
          name: team_name,
          oauth_token: team_oauth_token,
          channel: channel,
          channel_id: channel_id
        )
    else
      # Update exisitng team (reinstall)
      team.update!(
        name: team_name,
        oauth_token: team_oauth_token,
        channel: channel,
        channel_id: channel_id
      )
    end
  end
end
