module Muwu
  module ProjectException
    class OutlineFileNotFound
      
      
      def initialize(project)
        @filename = project.outline_filename
      end
      
      
      def report
        "The outline file `#{@filename}` could not be found."
      end
      
      
      def type
        :warning
      end


    end
  end
end    
    
