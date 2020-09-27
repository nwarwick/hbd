class Team < ApplicationRecord
  validates :slack_id, presence: true, uniqueness: true
  validates :domain, presence: true
end
