module Muwu
  module ProjectException
    class OutputNotOpen


      def initialize
        $stderr.puts "#{self.class}"
      end


      def type
        :internal
      end


    end
  end
end
