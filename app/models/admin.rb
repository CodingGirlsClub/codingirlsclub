# == Schema Information
#
# Table name: admins
#
#  id              :integer          not null, primary key
#  name            :string(80)
#  email           :string(80)
#  password_digest :string(255)
#  mobile          :string(20)
#  casting         :integer          default("0")
#  gender          :integer          default("0")
#  introduction    :text(65535)
#  avatar_url      :string(255)
#  city_id         :integer
#  last_login      :datetime
#  last_ip         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Admin < ApplicationRecord
  belongs_to :city
  
  has_secure_password validations: false
  validates :password, length: {in: 6..20 }
  validates_presence_of     :email, :name, :password
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
end
