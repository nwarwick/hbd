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
      puts "interaction: #{params}"
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

      if !ActiveSupport::SecurityUtils.secure_compare(
           signature,
           slack_signature
         )
        head :unauthorized
      end
    end
  end
end
