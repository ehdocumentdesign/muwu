module Muwu
  module ProjectException
    class OptionRemoteSyncValueNil


      def report
        "options.yml does not include a value for remote_sync"
      end


      def type
        :sync
      end


    end
  end
end