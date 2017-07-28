class Mentor < ApplicationRecord
  include AASM

  validates :city_id,          presence: true, on: :create
  validates :user_id,          presence: true, on: :create
  validates :introduce_self,   presence: true, length: { maximum: 200 }, on: :create
  validates :course_ids,       presence: true, on: :create
  validates :why_to_teach,     length: { maximum: 200 }
  validates :master_lang,      length: { maximum: 50 }
  validates :teaching_time,    length: { maximum: 50 }
  validates :wechat_id,        length: { maximum: 50 }
  validates :phone_number,     length: { maximum: 50 }
  validates :github_url,       length: { maximum: 255 }
  validates :ever_project_url, length: { maximum: 255 }
  validates :resume_url,       length: { maximum: 255 }

  belongs_to :user, optional: true
  belongs_to :city
  has_and_belongs_to_many :courses, join_table: :courses_mentors

  # 助教审核状态
  aasm column: :status, no_direct_assignment: true do
    state :status_fresh, initial: true # 待审核
    state :status_success              # 审核通过
    state :status_failed               # 审核不通过

    # 审核通过
    event :do_status_success do
      transitions from: [:status_fresh, :status_failed], to: :status_success
    end

    # 审核不通过
    event :do_status_failed do
      transitions from: :status_fresh, to: :status_failed
    end
  end
end
