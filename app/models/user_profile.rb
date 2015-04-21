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

class UserProfile < ActiveRecord::Base
  self.primary_key = :user_id

  VALID_USERNAME_REGEX = /\A\w+\z/

  belongs_to :user, inverse_of: :profile

  validates :user, presence: true
  validates :username, presence: true, length: { maximum: 15 },
                       format: { with: VALID_USERNAME_REGEX },
                       uniqueness: { case_sensitive: false }

  before_save { username.downcase! }

  def fullname
    self[:fullname] || username
  end
end
