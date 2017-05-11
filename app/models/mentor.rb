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
  belongs_to :user
  belongs_to :city, through: :user
end
