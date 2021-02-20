# frozen_string_literal: true

class Team < ApplicationRecord
  validates :slack_id, presence: true, uniqueness: true
  validates :channel, presence: true
  validates :channel_id, presence: true
  has_many :users, dependent: :destroy
end
