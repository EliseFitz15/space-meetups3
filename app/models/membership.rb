class Membership < ActiveRecord::Base

  belongs_to :user
  belongs_to :meetup
  validates_associated :user
  validates_associated :meetup
end
