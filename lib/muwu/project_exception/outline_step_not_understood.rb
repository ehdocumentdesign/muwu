module Muwu
  module ProjectException
    class OutlineStepNotUnderstood
   
   
      def initialize(step)
        @step = step
      end
      
      
      def report
        "Outline step `#{@step}` is not understood."
      end
      
      
      def type
        :warning
      end
      
      
    end
  end
end