module Muwu
  module ProjectException
    class OptionRemotePublishValueNil


      def report
        "options.yml does not include a value for remote_publish"
      end


      def type
        :publish
      end


    end
  end
end