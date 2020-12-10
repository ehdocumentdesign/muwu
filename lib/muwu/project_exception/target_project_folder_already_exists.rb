module Muwu
  module ProjectException
    class TargetProjectFolderAlreadyExists
      
      
      def initialize(project)
        @project_folder = project.working_directory
      end
      
      
      def report
        "The proposed directory `#{@project_folder}` already exists."
      end
      
      
      def type
        :fatal
      end


    end
  end
end    
    
