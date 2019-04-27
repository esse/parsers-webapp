module Validators
  class Date
    def self.valid?(date_string)
      begin
        ::Date.parse(date_string)
      rescue ArgumentError, TypeError
        return false
      end
      true
    end
  end
end
