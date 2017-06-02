class Ambassador < ApplicationRecord
  validates :user_id,           presence: true
  validates :self_introduction, presence: true, length: { maximum: 200 }
  validates :resume_url,        length: { maximum: 255 }

  belongs_to :user
end
