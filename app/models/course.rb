class Course < ApplicationRecord
  belongs_to :topic, optional: true
  has_and_belongs_to_many :courses, join_table: :courses_mentors
end
