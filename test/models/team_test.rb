# frozen_string_literal: true

require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  def setup
    @team = Team.new(domain: 'fwelmfsdflknwe', slack_id: 'sdfsfds')
  end

  test 'valid team' do
    assert @team.valid?
  end

  test 'invalid without slack_id' do
    @team.slack_id = nil
    assert_not @team.valid?
  end

  test 'invalid without domain' do
    @team.domain = nil
    assert_not @team.valid?
  end
end
