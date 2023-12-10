module Muwu
  class ProjectResetCss


    include Muwu


    require 'fileutils'


    def initialize(project)
      @project = project
    end


    public


    def reset_css
      phase_1_verify_or_create_css_folder
      phase_2_clear_base_folder
      phase_3_copy_base_css_files
      phase_4_verify_or_create_colors_folder
      phase_5_copy_colors_css_files
      phase_6_copy_index
      phase_7_verify_or_create_extensions_folder
    end


    def phase_1_verify_or_create_css_folder
      if Dir.exist?(@project.path_config) == false
        puts "Creating folder #{@project.path_config}"
        FileUtils.mkdir(@project.path_config)
      end
      if Dir.exist?(@project.path_css) == false
        puts "Creating folder #{@project.path_css}"
        FileUtils.mkdir(@project.path_css)
      end
    end


    def phase_2_clear_base_folder
      if Dir.exist?(@project.path_css_base) == true
        puts "Clearing folder #{@project.path_css_base}"
        FileUtils.remove_entry_secure(@project.path_css_base)
      end
    end


    def phase_3_copy_base_css_files
      folder_source_gem = File.absolute_path(File.join(Muwu::GEM_HOME_LIB, 'muwu','project_builder','assets','config','css','base'))
      folder_destination_project = @project.path_css_base
      puts "Resetting folder #{@project.path_css_base}"
      FileUtils.cp_r(folder_source_gem, folder_destination_project)
    end


    def phase_4_verify_or_create_colors_folder
      if Dir.exist?(@project.path_css_colors) == false
        puts "Creating folder #{@project.path_css_colors}"
        FileUtils.mkdir(@project.path_css_colors)
      end
    end


    def phase_5_copy_colors_css_files
      colors_source_gem = File.absolute_path(File.join(Muwu::GEM_HOME_LIB, 'muwu','project_builder','assets','config','css','colors','.'))
      colors_destination_project = @project.path_css
      puts "Resetting file #{File.join(@project.path_css_colors,'dark.scss')}"
      puts "Resetting file #{File.join(@project.path_css_colors,'index.scss')}"
      puts "Resetting file #{File.join(@project.path_css_colors,'light.scss')}"
      FileUtils.cp_r(colors_source_gem, colors_destination_project)
    end


    def phase_6_copy_index
      index_source_gem = File.absolute_path(File.join(Muwu::GEM_HOME_LIB, 'muwu','project_builder','assets','config','css','index.scss'))
      index_destination_project = @project.path_css
      puts "Resetting file #{File.join(@project.path_css, 'index.scss')}"
      FileUtils.cp_r(index_source_gem, index_destination_project)
    end


    def phase_7_verify_or_create_extensions_folder
      if Dir.exist?(@project.path_css_extensions) == false
        folder_source_gem = File.absolute_path(File.join(Muwu::GEM_HOME_LIB, 'muwu','project_builder','assets','config','css','extensions'))
        folder_destination_project = @project.path_css_extensions
        puts "Creating folder #{@project.path_css_extensions}"
        FileUtils.cp_r(folder_source_gem, folder_destination_project)
      end
    end


  end
end
