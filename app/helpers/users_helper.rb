module UsersHelper
  # 用户性别选择数组
  def user_gender_search_arr
    #[['男', User.genders[:gender_male]], ['女', User.genders[:gender_female]]]
    [['男', 'gender_male'], ['女', 'gender_female']]
  end

  # 用户年龄段选择数组
  def user_age_range_search_arr
    [['18岁 - 25岁', '18-25'], ['25岁 - 35岁', '25-35']]
  end

  # 是否是在校大学生选择数组
  def user_is_university_student_search_arr
    [['是', true], ['否', false]]
  end
end
