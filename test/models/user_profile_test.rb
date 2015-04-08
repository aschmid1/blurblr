# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  username   :string           not null
#  fullname   :string
#  bio        :text
#  website    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class UserProfileTest < ActiveSupport::TestCase
  setup do
    @profile = user_profiles(:one)
  end

  test "should require a username" do
    @profile.username = nil
    assert @profile.invalid?, "Accepted nil username"
    @profile.username = ""
    assert @profile.invalid?, "Accepted empty username"
    @profile.username = " "
    assert @profile.invalid?, "Accepted whitespace username"
  end

  test "should have unique username (case-insensitive)" do
    new_profile = user_profiles(:two)
    new_profile.username = @profile.username.upcase
    assert new_profile.invalid?
  end

  test "should save username as lower case" do
    lower_case_username = @profile.username.downcase
    @profile.username.upcase!
    @profile.save
    assert_equal lower_case_username, @profile.username
  end

  test "should accept valid username characters" do
    valid_usernames = %w[Foo_Bar123]
    valid_usernames.each do |username|
      @profile.username = username
      assert @profile.valid?, "Rejected #{username} as a username"
    end
  end

  test "should reject invalid username characters" do
    invalid_usernames = %w[@foobar foo@bar foo.bar foo+bar foo\ bar]
    invalid_usernames.each do |username|
      @profile.username = username
      assert @profile.invalid?, "Accepted #{username} as a username"
    end
  end

  test "should accept a short username" do
    @profile.username = "a" * 15
    assert @profile.valid?
  end

  test "should reject a long username" do
    @profile.username = "a" * 16
    assert @profile.invalid?
  end

  test "should have a user" do
    assert_respond_to @profile, :user, "User field is missing"
    assert_equal users(:one), @profile.user, "User :one is not assigned"

    @profile.user = nil
    assert @profile.invalid?, "Profile allowed to have no user"
  end
end
