# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  qa_id      :integer
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  belongs_to :qa
  has_many :answers
end
