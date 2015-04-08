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

  belongs_to :user
end
