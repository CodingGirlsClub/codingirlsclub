class Qa < ApplicationRecord
  # 问题类型，AmbassadorQa: 校园大使申请
  CATEGORIES_NAME = %w(AmbassadorQa)

  validates :title,       presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 200 }
  validates :category,    presence: true

  has_many :questions
end
