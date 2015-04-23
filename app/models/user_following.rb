# == Schema Information
#
# Table name: user_followings
#
#  id           :integer          not null, primary key
#  follower_id  :integer          not null
#  following_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class UserFollowing < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
