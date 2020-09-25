# frozen_string_literal: true

Slack.configure do |config|
  config.token = ENV['SLACK_BOT_TOKEN']
  raise 'Missing API token' unless config.token
end
