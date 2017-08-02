module Cgc
  module AmbassadorsHelper
    def cgc_ambassadors_status_name_for(ambassador)
      I18n.t(ambassador.status, scope: 'activerecord.attributes.ambassador.status_aasm')
    end

    def cgc_ambassadors_status_option_for_select
      Ambassador.aasm.states.map(&:name).each_with_object([]) {|status, arr| arr.push([I18n.t(status, scope: 'activerecord.attributes.ambassador.status_aasm'), status])}
    end
  end
end
