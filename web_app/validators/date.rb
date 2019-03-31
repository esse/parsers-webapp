module Validators
  class Date
    def self.is_valid?(date_string)
      begin
        ::Date.parse(date_string)
      rescue ArgumentError
        return false
      end
      true
    end
  end
end
