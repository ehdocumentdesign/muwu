module Muwu
  module ProjectException
    class ViewerMissingHomeDocument


      def initialize
        $stderr.puts "#{self.class}"
      end


      def report
        "Viewer cannot find a compiled home document."
      end


      def type
        :view
      end


    end
  end
end
