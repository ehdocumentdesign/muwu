module Muwu
  module ProjectException
    class MultipleFormatsRequestedWithStdout


      def report
        'The output destination `stdout` can only accommodate a single output format.'
      end

      
      def type
        :fatal
      end      


    end
  end
end
