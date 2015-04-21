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

class Blurb < ActiveRecord::Base
  default_scope { order(:created_at).reverse_order }

  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
