module Muwu
  class ProjectWriter


    include Muwu
    include Helper


    require 'fileutils'
    require 'yaml'


    attr_accessor(
      :project
    )


    def initialize(project)
      @project = project
    end


    public


    def write
      if Dir.exist?(@project.working_directory) == false
        puts '# Writing project'
        phase_1_make_project_folder
        phase_2_make_project_subfolders
        phase_2_make_folder_css_and_copy_files
        phase_3_write_file_metadata_yml
        phase_3_write_file_options_yml
        phase_3_write_file_outline_yml
        puts "\n"
        puts '# Project written.'

      elsif Dir.exist?(@project.working_directory) == true
        raise ProjectExceptionHandler::Fatal.new(ProjectException::TargetProjectFolderAlreadyExists.new(@project))

      end
    end


    def phase_1_make_project_folder
      announce_and_execute_dir_mkdir(@project.working_directory)
    end


    def phase_2_make_project_subfolders
      announce_and_execute_dir_mkdir(@project.path_compiled)
      announce_and_execute_dir_mkdir(@project.path_config)
      # announce_and_execute_dir_mkdir(@project.path_images)    # DEPRECATED
      announce_and_execute_dir_mkdir(@project.path_text)
    end


    def phase_2_make_folder_css_and_copy_files
      folder_source_gem = File.absolute_path(File.join(Muwu::GEM_HOME_LIB, 'muwu','project_builder','assets','config','css'))
      folder_destination_project = @project.path_css
      announce_and_execute_fileutils_cp_r(folder_source_gem, folder_destination_project)
    end


    def phase_3_write_file_metadata_yml
      announce_and_execute_yaml_dump(HashHelper.human_readable_hash(@project.metadata), @project.metadata_filename)
    end


    def phase_3_write_file_options_yml
      announce_and_execute_yaml_dump(HashHelper.human_readable_hash(@project.options), @project.options_filename)
    end



    def phase_3_write_file_outline_yml
      if @project.outline.any?
        phase_3_write_file_outline_yml_dump
      elsif @project.outline.empty?
        phase_3_write_file_outline_yml_blank
      end
    end


    def phase_3_write_file_outline_yml_dump
      announce_and_execute_yaml_dump(@project.outline, @project.outline_filename)
    end


    def phase_3_write_file_outline_yml_blank
      announce_and_execute_fileutils_touch(@project.outline_filename)
    end



    private


    def announce_and_execute_dir_mkdir(dir)
      print "- Making directory".ljust(18)
      puts "  `#{dir}`"
      Dir.mkdir(dir)
    end


    def announce_and_execute_fileutils_cp_r(folder_source_gem, folder_destination_project)
      print "- Writing tree".ljust(18)
      puts "  `#{folder_destination_project}`"
      FileUtils.cp_r(folder_source_gem, folder_destination_project)
    end


    def announce_and_execute_fileutils_touch(filename)
      print "- Writing file".ljust(18)
      puts "  `#{filename}`"
      FileUtils.touch(filename)
    end


    def announce_and_execute_yaml_dump(obj, filename)
      print "- Writing file".ljust(18)
      puts "  `#{filename}`"
      File.open(filename,'w') { |file| YAML.dump(obj, file, canonical: false) }
    end


  end
end
