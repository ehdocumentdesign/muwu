module Muwu
  class CliHelp


      def initialize(message)
        @heading = File.open(File.join(GEM_HOME_LIB_MUWU,'cli/help/heading')).read.strip
        @version = "#{version_statement}\n"
        @message = File.open(File.join(GEM_HOME_LIB_MUWU,'cli/help',message.to_s.downcase)).read.strip
      end


      def message
        [@heading, @version, @message].join("\n")
      end



      private


      def version_statement
        "\# version #{VERSION}"
      end


  end
end

