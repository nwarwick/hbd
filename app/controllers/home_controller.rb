class HomeController < ApplicationController
  def index
    authorize if params[:code]
  end

  def install
    code = params[:code]
    client = Slack::Web::Client.new(token: ENV['SLACK_BOT_TOKEN'])
    client.oauth_v2_access(
      {
        code: code,
        client_id: ENV['CLIENT_ID'],
        client_secret: ENV['CLIENT_SECRET']
      }
    )
    flash[:notice] = 'Successfully installed!'
  rescue StandardError => e
    puts "Something went wrong: #{e}"
    flash[:notice] = 'Something went wrong :('
  end
end
