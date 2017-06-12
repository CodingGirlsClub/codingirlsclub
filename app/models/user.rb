# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(80)
#  full_name       :string(80)
#  email           :string(80)
#  password_digest :string(255)
#  mobile          :string(20)
#  gender          :integer          default("0")
#  age_range       :string(20)
#  introduction    :text(65535)
#  avatar          :string(255)
#  id_photo        :string(255)
#  github_url      :string(255)
#  wechat_id       :string(80)
#  city_id         :integer
#  university_id   :integer
#  last_login      :datetime
#  last_ip         :string(255)
#  description     :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password validations: false
  validates :password, length: {in: 6..20 }
  validates_presence_of     :email, :name, :password
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  belongs_to :city
  belongs_to :university, optional: true

  has_one :ambassador
  has_one :mentor
  has_many :accounts
  has_many :answers

end
