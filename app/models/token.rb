# == Schema Information
#
# Table name: tokens
#
#  id         :integer          not null, primary key
#  name       :string(40)
#  general    :boolean          default("0")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Token < ApplicationRecord
end
