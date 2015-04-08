# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should require an email" do
    @user.email = nil
    assert @user.invalid?, "Accepted nil email"
    @user.email = ""
    assert @user.invalid?, "Accepted empty email"
    @user.email = " "
    assert @user.invalid?, "Accepted whitespace email"
  end

  test "should have a unique email (case-insensitive)" do
    new_user = users(:two)
    new_user.email = @user.email.upcase
    assert new_user.invalid?
  end

  test "should save email as lower case" do
    lower_case_email = @user.email.downcase
    @user.email.upcase!
    @user.save
    assert_equal lower_case_email, @user.email
  end

  test "should accept valid emails" do
    valid_emails = %w[foo@bar.com user.foo@bar.com foo+extra@bar.ca]
    valid_emails.each do |email|
      @user.email = email
      assert @user.valid?, "Rejected #{email} as an email"
    end
  end

  test "should reject invalid emails" do
    invalid_emails = %w[foo@bar. foo@bar,com foo@bar.c@m has\ space@example.com]
    invalid_emails.each do |email|
      @user.email = email
      assert @user.invalid?, "Accepted #{email} as an email"
    end
  end

  test "should require a password" do
    @user.password_digest = nil
    assert @user.invalid?, "Accepted nil password"
    @user.password_digest = ""
    assert @user.invalid?, "Accepted empty password"
    @user.password_digest = " "
    assert @user.invalid?, "Accepted whitespace password"
  end

  test "should have a profile" do
    assert_respond_to @user, :profile, "Profile field is missing"
    assert_equal user_profiles(:one), @user.profile, "Profile :one is not assigned"

    @user.profile = nil
    assert @user.invalid?, "User allowed to have no profile"
  end

  test "should destroy dependent profile" do
    profile_id = @user.profile.user_id
    @user.destroy
    assert_nil UserProfile.find_by_user_id(profile_id)
  end

  test "should have blurbs" do
    assert_respond_to @user, :blurbs, "blurbs field is missing"
    assert_includes @user.blurbs, blurbs(:one), "Blurb :one is not assigned"
  end

  test "should destroy dependent blurbs" do
    blurbs = @user.blurbs
    @user.destroy
    blurbs.each do |blurb|
      assert_nil Blurb.find_by_id(blurb.id)
    end
  end
end
