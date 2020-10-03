# frozen_string_literal: true

module Slack
  # Handle commands from Slack
  class CommandsController < ApplicationController
    before_action :verify_slack_request, except: %i[checkup]

    def create
      puts "params#{params}"
      render status: :ok, json: ::Constants::SLACK_COMMAND_RESPONSE
    end

    def interaction
      json = JSON.parse(params[:payload])
      handle_team_creation(json)
      handle_user_creation(json)
    end

    def checkup
      render status: :ok, json: { message: 'Everything is fine!' }
    end

    private

    # Verify that the request actually came from Slack
    def verify_slack_request
      timestamp = request.headers['X-Slack-Request-Timestamp']
      if (Time.now.to_i - timestamp.to_i).abs > 60 * 5
        head :unauthorized
        return { error: 'Unathorized' }
      end

      sig_basestring = "v0:#{timestamp}:#{request.raw_post}"
      signature =
        'v0=' +
        OpenSSL::HMAC.hexdigest(
          'SHA256',
          ENV['SIGNING_SECRET'],
          sig_basestring
        )
      slack_signature = request.headers['X-Slack-Signature']

      unless ActiveSupport::SecurityUtils.secure_compare(
        signature,
        slack_signature
      )
        head :unauthorized
      end
    end

    def handle_team_creation(json)
      team_json = json['team']
      team_slack_id = team_json['id']
      @team_domain = team_json['domain']
      @team = Team.find_by_slack_id(team_slack_id)
      return unless @team.blank?

      @team = Team.create!(slack_id: team_slack_id, domain: @team_domain)
    end

    def handle_user_creation(json)
      user = json['user']
      user_name = user['name']
      user_slack_id = user['id']
      if User.find_by_slack_id(@team_domain).blank?
        User.create!(
          slack_id: user_slack_id,
          name: user_name,
          team_id: @team.id,
          birthday: Time.now + 10 # TODO: Use date contained in the payload
        )
      else
        # TODO: Updater user's birthday
      end
    end
  end
end
