module Cgc
  module QasHelper
    def cgc_qas_types_select
      Qa::TYPES_NAME
    end

    def cgc_qas_applied_select
      [['是', true], ['否', false]]
    end
  end
end
