# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :slack_id, :birthday, :presence => true
  validates :slack_id, uniqueness: true
  belongs_to :team, optional: false

  scope :born_today,
        lambda {
          where(
            'EXTRACT(day FROM birthday) = ? AND EXTRACT(month FROM birthday) = ?',
            Time.now.day,
            Time.now.month
          )
        }
end
