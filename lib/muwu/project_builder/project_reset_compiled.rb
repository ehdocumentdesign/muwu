module Muwu
  class ProjectResetCompiled


    require 'fileutils'


    include Muwu


    def initialize(project)
      @project = project
    end


    public


    def reset_compiled
      puts "- Resetting #{@project.path_compiled}"
      begin
        FileUtils.remove_entry_secure(@project.path_compiled)
      rescue Errno::ENOENT
      ensure
        FileUtils.mkdir(@project.path_compiled)
      end
    end


  end
end
