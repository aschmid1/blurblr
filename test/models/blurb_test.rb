# == Schema Information
#
# Table name: blurbs
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class BlurbTest < ActiveSupport::TestCase
  setup do
    @blurb = blurbs(:one)
  end

  test "should accept short content" do
    @blurb.content = "a" * 140
    assert @blurb.valid?
  end

  test "should reject long content" do
    @blurb.content = "a" * 141
    assert @blurb.invalid?
  end

  test "should reject blank content" do
    @blurb.content = ""
    assert @blurb.invalid?, "Accepted empty content"
    @blurb.content = "  "
    assert @blurb.invalid?, "Accepted whitespace content"
  end
end
