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

require 'test_helper'

class UserFollowingTest < ActiveSupport::TestCase
  setup do
    @follower = users(:one)
    @followed = users(:two)
    @relation = user_followings(:one)
  end

  test "follower should be following followed" do
    assert_includes @follower.following, @followed
    assert @follower.is_following?(@followed)
  end

  test "followed should be followed by follower" do
    assert_includes @followed.followers, @follower
  end

  test "should create a new following association" do
    @followed.follow(@follower.id)
    assert_includes @followed.following, @follower
  end

  test "should not allow following of self" do
    @follower.follow(@follower.id)
    assert @follower.invalid?
    assert_not_includes @follower.following, @follower
  end

  test "should destroy dependent following relations" do
    @follower.destroy
    assert_nil UserFollowing.find_by(id: @relation.id)
  end

  test "should destroy dependent follower relations" do
    @followed.destroy
    assert_nil UserFollowing.find_by(id: @relation.id)
  end
end
