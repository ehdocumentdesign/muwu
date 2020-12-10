module Muwu
  class ProjectStarter


    include Muwu


    def initialize(current_working_directory, metadata)
      @current_working_directory = File.absolute_path(current_working_directory)
      @metadata = metadata
    end


    public


    def new_project
      project = Project.new
      project.metadata = @metadata
      project.options = Default::PROJECT_OPTIONS
      project.working_directory = File.absolute_path(File.join(@current_working_directory, @metadata[:slug]))
      project
    end


  end
end
