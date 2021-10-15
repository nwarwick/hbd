# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'when team is not present on build' do
    user = User.new

    assert user.valid? == false
  end

  test 'when team is present on build' do
    team = Team.create!(slack_id: 'x', channel: 'y', channel_id: 'z')
    user = User.new(team: team
    )
    assert user.valid? == true
  end

  test "#born_today" do
    team = Team.create!(slack_id: 'x', channel: 'y', channel_id: 'z')
    born_today = User.create!(name: 'foo', birthday: Date.today, team: team, slack_id: 'x')
    born_yesterday = User.create!(name: 'bar', birthday: Date.yesterday, team: team, slack_id: 'y')

    users = User.born_today

    assert users.count == 1
    assert users.first == born_today
  end
end
