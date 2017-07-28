class Qa < ApplicationRecord
  # 问题类型，AmbassadorQa: 校园大使申请
  TYPES_NAME = %w(AmbassadorQa)

  has_many :questions
end
