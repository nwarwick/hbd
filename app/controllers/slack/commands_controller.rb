# frozen_string_literal: true

module Slack
   # Handle commands from Slack
  class CommandsController < ApplicationController
    before_action :verify_slack_request, except: %i[checkup]

    def create
      team = Team.find_by_slack_id(params['team_id'])
      client = Slack::Web::Client.new(token: team.oauth_token)
      client.auth_test
      begin
        client.chat_postEphemeral(
          user: params['user_id'],
          channel: params['channel_id'],
          blocks: ::Constants::SLACK_DATEPICKER
        )
      rescue Slack::Web::Api::Errors::ValidationErrors => e
        puts "Validation Error(s): #{e.response_metadata.messages}"
      end
    end

    def interaction
      json = JSON.parse(params[:payload])
      handle_team_update(json)
      handle_user_creation(json)
      handle_success_message(json)
    end

    def checkup
      render status: :ok, json: { message: 'Everything is fine!' }
    end

    private

    def handle_team_update(json)
      team_json = json['team']
      team_slack_id = team_json['id']
      team_domain = team_json['domain']
      @team = Team.find_by_slack_id(team_slack_id)
      @team.update!(domain: team_domain)
    end

    def handle_user_creation(json)
      user = json['user']
      user_name = user['name']
      user_slack_id = user['id']
      birthday = parse_birthday(json)
      existing_user = User.find_by_slack_id(user_slack_id)
      if existing_user.blank?
        User.create!(
          slack_id: user_slack_id,
          name: user_name,
          team_id: @team.id,
          birthday: birthday
        )
      else
        existing_user.update!(birthday: birthday)
      end
    end

    def handle_success_message(json)
      client = Slack::Web::Client.new(token: @team.oauth_token)
      client.auth_test
      client.chat_postEphemeral(
        user: json['user']['id'],
        channel: json['channel']['id'],
        blocks: ::Constants::SLACK_SUCCESS_MESSAGE
      )
    end

    def parse_birthday(json)
      json['state']['values']['datepicker-block']['datepicker-action'][
        'selected_date'
      ]
    end
  end
end
