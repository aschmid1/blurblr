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

  validates :follower, presence: true
  validates :following, presence: true

  validate :not_following_self

  private
    def not_following_self
      errors.add(:base, "Cannot follow yourself") if following == follower
    end
end
