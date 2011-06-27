class Checkin < ActiveRecord::Base
  has_one :user
  has_one :venue
end
