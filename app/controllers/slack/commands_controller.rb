# frozen_string_literal: true

module Slack
  # Handle commands from Slack
  class CommandsController < ApplicationController
    before_action :verify_slack_request, except: %i[checkup]

    def create
      client = Slack::Web::Client.new(token: ENV['SLACK_BOT_TOKEN'])
      client.auth_test
      begin
        client.dialog_open(
          dialog: ::Constants::SLACK_DATEPICKER,
          trigger_id: params['trigger_id'],
          callback_id: 'datepicker-form'
        )
      rescue Slack::Web::Api::Errors::ValidationErrors => e
        puts "Validation Error(s): #{e}"
      end
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
      birthday = json['submission']['birthday']
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
  end
end
