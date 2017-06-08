# == Schema Information
#
# Table name: ambassadors
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  self_introduction :string(255)
#  applied           :boolean          default("0")
#  resume_url        :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Ambassador < ApplicationRecord
  belongs_to :user

  def university
    user.university
  end
end
