class User < ApplicationRecord
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
