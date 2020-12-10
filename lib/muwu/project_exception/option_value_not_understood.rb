module Muwu
  module ProjectException
    class OptionValueNotUnderstood


      def initialize(key, value)
        @key = key
        @value = value
      end
      

      def report
        "For option key `#{@key}`, the value `#{@value}` is not understood."
      end


      def type
        :warning
      end


    end
  end
end
