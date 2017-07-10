# == Schema Information
#
# Table name: universities
#
#  id          :integer          not null, primary key
#  city_id     :integer
#  name        :string(50)
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class University < ApplicationRecord
  belongs_to :city
  has_many :users
end
