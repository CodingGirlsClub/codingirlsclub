module Cgc
  module Tools
    class Regular
      Email = %r/\A\w+(?:[0-9a-zA-Z_.-]*)@\w+(?:[0-9a-zA-Z_-]*)\.(?:[0-9a-zA-Z]{2,4}\.[0-9a-zA-Z]{2,4}|[0-9a-zA-Z]{2,4})\Z/
      MobilePhone = %r/\A1[3|4|5|7|8]\d{9}\Z/
      Money = %r/\A[0-9]+[.][0-9]{,2}\Z|\A[0-9]+\Z/

      class << self
        # Cgc::Tools::Regular.match_email()
        def match_email(email)
          email.to_s.match Email
        end

        def match_mobile_phone(number)
          number.to_s.match MobilePhone
        end

        def match_phone_or_email(str)
          match_email(str) or match_mobile_phone(str)
        end

        def match_money(money)
          money.to_s.match Money
        end
        
      end
    end
  end
end