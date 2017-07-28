class Followership < ActiveRecord::Base

  belongs_to :user
  belongs_to :follower, :class => 'User'
end
