class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }

  belongs_to :qa
  has_many :answers
end
