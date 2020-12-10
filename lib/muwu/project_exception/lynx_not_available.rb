module Muwu
  module ProjectException
    class LynxNotAvailable


      def initialize
        $stderr.puts "#{self.class}"
      end


      def report
        "lynx is not available"
      end


      def type
        :view
      end


    end
  end
end
