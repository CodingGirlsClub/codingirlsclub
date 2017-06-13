class Qa < ApplicationRecord
  has_many :questions, inverse_of: :qa, dependent: :destroy
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true
end
