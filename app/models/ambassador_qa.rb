class AmbassadorQa < Qa
  scope :applied_qa, -> { where(applied: true).order(id: :desc).first }
end
