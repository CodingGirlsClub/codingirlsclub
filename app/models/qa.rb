# == Schema Information
#
# Table name: qas
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  type        :string(255)
#  applied     :boolean          default("0")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Qa < ApplicationRecord
  has_many :questions, inverse_of: :qa, dependent: :destroy
end
