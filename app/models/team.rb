# frozen_string_literal: true

class Team < ApplicationRecord
  validates :slack_id, presence: true, uniqueness: true
  validates :domain, presence: true
  validates :channel, presence: true
  validates :channel_id, presence: true
  has_many :users
end
