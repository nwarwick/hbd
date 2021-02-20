# frozen_string_literal: true

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @team = teams(:valid_team)
  end

  test 'valid team' do
    assert @team.valid?
  end

  test 'invalid without slack_id' do
    @team.slack_id = nil
    assert_not @team.valid?
  end

  test 'invalid without channel' do
    @team.channel = nil
    assert_not @team.valid?
  end

  test 'invalid without channel id' do
    @team.channel_id = nil
    assert_not @team.valid?
  end
end
