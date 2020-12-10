module Muwu
  module ProjectException
    class OptionKeyNotUnderstood


      def initialize(key)
        @key = key
      end
      

      def report
        "The option key `#{@key}` is not understood."
      end
      
      
      def type
        :warning
      end


    end
  end
end
