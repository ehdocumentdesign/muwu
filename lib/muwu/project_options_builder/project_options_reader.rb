module Muwu
  class ProjectOptionsReader


    include Muwu
    
    
    require 'yaml'


    attr_accessor(
      :options_from_file,
      :options_validated,
      :project_options
    )


    def self.build
      builder = new
      yield(builder)
      builder.project_options
    end
  
  
    def initialize
      @options_from_file = {}
      @options_validated = {}
      @project_options = ProjectOptions.new
    end
  
  
  
    public


    def build_from_ymlfile(project)
      @project = project
      phase_1_read_options_file
      phase_2_validate_options_file
      phase_3_set_project_options
    end


    def phase_1_read_options_file
      if ProjectValidator.new(@project).validate_file_options
        @options_from_file = YAML.load_file(@project.options_filename)
      end
    end


    def phase_2_validate_options_file
      @options_validated = validate_options(@options_from_file)
    end


    def phase_3_set_project_options
      @options_validated.each_pair do |key, value|
        @project_options.set_option(key, value)
      end
    end



    private
  
  
    def validate_options(options)
      result = {}
      options.each_pair do |key, value|
        valid_option = ProjectOptionValidator.new_if_valid_key(key, value, @project)
        if valid_option
          result[valid_option.key] = valid_option.value
        end
      end
      result.reject { |k,v| (v == nil) || (v == '') }
    end
  

  end
end
