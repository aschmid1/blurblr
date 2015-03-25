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
    @new_user = User.new(email: 'NEW@email.com', password_digest: @user.password_digest)
  end

  test "emails should be unique (case-insensitive)" do
    @new_user.email = @user.email.upcase
    assert @new_user.invalid?
  end

  test "emails should save as lower case" do
    lower_case_email = @new_user.email.downcase
    @new_user.save
    assert_equal lower_case_email, @new_user.email
  end

  test "should accept valid emails" do
    valid_emails = %w[foo@bar.com user.foo@bar.com foo+extra@bar.ca]
    valid_emails.each do |email|
      @new_user.email = email
      assert @new_user.valid?
    end
  end

  test "should reject invalid emails" do
    invalid_emails = %w[foo@bar. foo@bar,com foo@bar.c@m]
    invalid_emails.each do |email|
      @new_user.email = email
      assert @new_user.invalid?
    end
  end

  test "should require password" do
    @new_user.password_digest = ''
    assert @new_user.invalid?
  end
end
