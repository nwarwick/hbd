# frozen_string_literal: true

module Slack
  class CommandsControllerTest < ActionDispatch::IntegrationTest
    test 'Command post fails without slack header' do
      post '/slack/command'
      assert_response :unauthorized
    end
  end
end
