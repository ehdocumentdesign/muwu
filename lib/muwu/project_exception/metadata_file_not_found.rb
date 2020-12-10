module Muwu
  module ProjectException
    class MetadataFileNotFound



      def initialize(project)
        @filename = project.metadata_filename
      end
      
      
      def report
        "The metadata file `#{@filename}` could not be found."
      end

      
      def type
        :warning
      end


    end
  end
end
