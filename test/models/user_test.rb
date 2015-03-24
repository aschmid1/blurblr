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

  test "emails should be unique (case-insensitive)" do
    existing = users(:one)

    user = User.new(email: existing.email.upcase, password_digest: 'secret')
    assert user.invalid?
  end

  test "emails should save as lower case" do
    user = User.new(email: 'NEW@EMAIL.COM', password_digest: 'secret')
    user.save
    assert_equal 'new@email.com', user.email
  end

  test "should accept valid emails" do
    valid_emails = %w[foo@bar.com user.foo@bar.com foo+extra@bar.ca]
    valid_emails.each do |email|
      user = User.new(email: email, password_digest: 'secret')
      assert user.valid?
    end
  end

  test "should reject invalid emails" do
    invalid_emails = %w[foo@bar. foo@bar,com foo@bar.c@m]
    invalid_emails.each do |email|
      user = User.new(email: email, password_digest: 'secret')
      assert user.invalid?
    end
  end

end
