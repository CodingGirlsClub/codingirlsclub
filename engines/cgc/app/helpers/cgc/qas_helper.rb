module Cgc
  module QasHelper
    def cgc_qas_categories_select
      Qa::CATEGORIES_NAME
    end

    def cgc_qas_status_option_for_select
      Qa.aasm.states.map(&:name).each_with_object([]) { |status, arr| arr.push([I18n.t(status, scope: 'activerecord.attributes.qa.status_aasm'), status]) }
    end

    def cgc_qas_status_name_for(qa)
      I18n.t(qa.status, scope: 'activerecord.attributes.qa.status_aasm')
    end
  end
end
