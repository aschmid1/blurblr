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
  belongs_to :user
  validates_presence_of :user

  validates :content, presence: true, length: { maximum: 140 }

  default_scope { order(:created_at).reverse_order }
end
