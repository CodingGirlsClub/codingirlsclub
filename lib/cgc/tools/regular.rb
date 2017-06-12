module Cgc
  module Tools
    class Regular
      Email = %r/\A\w+(?:[0-9a-zA-Z_.-]*)@\w+(?:[0-9a-zA-Z_-]*)\.(?:[0-9a-zA-Z]{2,4}\.[0-9a-zA-Z]{2,4}|[0-9a-zA-Z]{2,4})\Z/

      class << self
        # Cgc::Tools::Regular.match_email()
        def match_email(email)
          email.to_s.match Email
        end
        
      end
    end
  end
end