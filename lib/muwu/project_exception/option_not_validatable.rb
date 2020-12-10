module Muwu
  module ProjectException
    class OptionNotValidatable


      def initialize(key)
        @key = key
      end
      

      def report
        "The option `#{@key}` cannot be validated. (Muwu::ProjectOptionValidatorValue)"
      end
      
      
      def type
        :internal
      end


    end
  end
end
