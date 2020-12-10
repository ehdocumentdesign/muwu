module Muwu
  module ProjectException
    class CssManifestFileNotFound


      def initialize(css_manifest_filename)
        @css_manifest_filename = css_manifest_filename
      end
      

      def report 
        "The css manifest file `#{@css_manifest_filename}` could not be found."
      end
      

      def type
        :warning
      end


    end
  end
end
