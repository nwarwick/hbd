# frozen_string_literal: true

class Team < ApplicationRecord
  validates :slack_id, presence: true, uniqueness: true
  has_many :users
end
