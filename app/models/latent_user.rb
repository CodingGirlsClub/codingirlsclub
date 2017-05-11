# == Schema Information
#
# Table name: latent_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  email      :string(80)
#  active     :boolean          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class LatentUser < ApplicationRecord
  belongs_to :user, optional: true

  validates_presence_of     :email
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
