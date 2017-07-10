# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  country    :string(40)
#  province   :string(40)
#  name       :string(40)
#  district   :string(40)
#  zipcode    :string(40)
#  parent_id  :integer
#  level      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  has_many :users
  has_many :universities
  has_many :admins
  # has_many :clubs
  has_many :children, class_name: "City", foreign_key: "parent_id"
  belongs_to :parent, class_name: "City", optional: true

  scope :provinces, ->{where(level: 1)}

  def self.vaid_city_id?(v)
    provinces.map(&:id).include?(v.to_i)
  end
end