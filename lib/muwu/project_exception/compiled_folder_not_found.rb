module Muwu
  module ProjectException
    class CompiledFolderNotFound


      def initialize(project)
        @compiled_folder = project.path_compiled
      end


      def report
        "The folder for compiled documents `#{@compiled_folder}` could not be found."
      end


      def type
        :fatal
      end


    end
  end
end
