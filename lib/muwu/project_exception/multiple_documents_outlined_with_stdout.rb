module Muwu
  module ProjectException
    class MultipleDocumentsOutlinedWithStdout


      def report
        'The output destination `stdout` can only accommodate a single outlined document.'
      end

      
      def type
        :fatal
      end


    end
  end
end
