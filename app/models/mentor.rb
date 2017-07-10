# == Schema Information
#
# Table name: mentors
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  introduce_self   :text(65535)
#  why_to_teach     :text(65535)
#  master_lang      :string(255)
#  teaching_time    :string(255)
#  phone_number     :string(255)
#  wechat_id        :string(255)
#  github_url       :string(255)
#  ever_project_url :string(255)
#  resume_url       :string(255)
#  applied          :boolean          default("0")
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Mentor < ApplicationRecord
  # FIXME: validates :city_id,          presence: true
  validates :user_id,          presence: true
  validates :introduce_self,   presence: true, length: { maximum: 200 }
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

  def city
    user.city
  end
end
