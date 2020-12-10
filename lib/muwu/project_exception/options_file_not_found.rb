module Muwu
  module ProjectException
    class OptionsFileNotFound
      
      
      def initialize(project)
        @filename = project.options_filename
      end
      
      
      def report
        "The options file `#{@filename}` could not be found."
      end
      
      
      def type
        :warning
      end


    end
  end
end    
    
