module Muwu
  module ProjectException
    class ScpNotAvailable


      def initialize
        $stderr.puts "#{self.class}"
      end

      
      def report
        "scp is not available"
      end


      def type
        :publish
      end


    end
  end
end