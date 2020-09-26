class User < ApplicationRecord
  belongs_to :team, optional: false
end
