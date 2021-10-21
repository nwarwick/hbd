# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  class UserValidations < ActiveSupport::TestCase
    team = Team.create!(slack_id: 'x', channel: 'y', channel_id: 'z')
    required_params = {
      team: team,
      name: 'foo',
      slack_id: 2,
      birthday: Date.today
    }

    [:name, :team, :slack_id, :birthday].each do |field|
      test "when #{field} is not present on build" do
        user = User.new(required_params.except(field))

        assert user.valid? == false
      end
    end

    test 'when slack id has already been taken' do
      user = User.last
      user_2 = User.new(required_params.merge({slack_id: user.slack_id}))

      user_2.valid? == false
      user.destroy
    end

    test 'when all required params are present on build' do
      user = User.new(required_params)
      assert user.valid? == true
    end
  end

  class UserScopes < ActiveSupport::TestCase
    test "#born_today" do
      team = Team.create!(slack_id: 'a', channel: 'y', channel_id: 'z')
      born_today = User.create!(name: 'foo', birthday: Date.today, team: team, slack_id: 'x')
      born_yesterday = User.create!(name: 'bar', birthday: Date.yesterday, team: team, slack_id: 'y')

      users = User.born_today

      assert users.count == 1
      assert users.first == born_today
    end
  end
end
