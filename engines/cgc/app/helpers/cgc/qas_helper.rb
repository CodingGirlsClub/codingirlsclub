module Cgc
  module QasHelper
    def cgc_qas_categories_select
      Qa::CATEGORIES_NAME
    end

    def cgc_qas_applied_select
      [['是', true], ['否', false]]
    end
  end
end
