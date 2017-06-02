class Mentor < ApplicationRecord
  validates :introduce_self,   presence: true, length: { maximum: 200 }
  validates :city_id,          presence: true
  validates :course_ids,       presence: true
  validates :why_to_teach,     length: { maximum: 200 }
  validates :master_lang,      length: { maximum: 50 }
  validates :teaching_time,    length: { maximum: 50 }
  validates :wechat_id,        length: { maximum: 50 }
  validates :phone_number,     length: { maximum: 50 }
  validates :github_url,       length: { maximum: 255 }
  validates :ever_project_url, length: { maximum: 255 }
  validates :resume_url,       length: { maximum: 255 }

  belongs_to :user, optional: true
  has_and_belongs_to_many :courses, join_table: :courses_mentors
end
