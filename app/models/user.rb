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

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_one :profile, class_name: 'UserProfile', inverse_of: :user, dependent: :destroy
  has_many :blurbs, dependent: :destroy

  validates_presence_of :profile

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  before_validation :create_default_profile, on: :create
  before_save { email.downcase! }

  def to_s
    profile.fullname || profile.username
  end

  protected
    def create_default_profile
      unless profile && profile.valid?
        default_username = email.split("@").first
                                .gsub(/\W/, "_")
                                .truncate(15, omission: "")

        prefix = default_username
        counter = 1
        until UserProfile.find_by_username(default_username).nil?
          default_username = (prefix + counter.to_s).truncate(15, omission: counter.to_s)
          counter += 1
        end

        build_profile(username: default_username)
      end
    end
end
