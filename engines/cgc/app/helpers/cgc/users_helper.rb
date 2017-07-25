module Cgc
  module UsersHelper
    def cgc_users_is_university_student_select
      [['是', true], ['否', false]]
    end

    def cgc_users_gender_select
      [['男', User.genders[:gender_male]], ['女', User.genders[:gender_female]]]
    end
  end
end
