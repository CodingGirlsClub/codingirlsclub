module Cgc
  module MentorsHelper
    def cgc_mentors_status_name_for(mentor)
      I18n.t(mentor.status, scope: 'activerecord.attributes.mentor.status_aasm')
    end
  end
end
