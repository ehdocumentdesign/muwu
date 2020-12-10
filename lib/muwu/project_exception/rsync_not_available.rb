module Muwu
  module ProjectException
    class RsyncNotAvailable


      def initialize
        $stderr.puts "#{self.class}"
      end

      
      def report
        "rsync is not available"
      end


      def type
        :sync
      end


    end
  end
end