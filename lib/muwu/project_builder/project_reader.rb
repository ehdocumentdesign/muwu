module Muwu
  class ProjectReader


    include Muwu
    include Helper


    require 'yaml'


    attr_accessor(
      :path,
      :project,
      :validator
    )


    def self.build
      builder = new
      yield(builder)
      builder.project
    end


    def initialize
      @project = Muwu::Project.new
    end


    def load_path(path)
      @path = File.absolute_path(path)
      @validator = ProjectValidator.new(@project)
      phase_1_set_project_working_directory
      phase_2_read_metadata
      phase_2_read_options
      phase_2_read_outline
      phase_3_set_javascript_libraries_requested
      phase_3_set_metadata_instance_date
      phase_4_validate
      phase_5_build_manifest
    end


    def phase_1_set_project_working_directory
      @project.working_directory = @path
    end


    def phase_2_read_metadata
      if @validator.validate_file_metadata
        @project.metadata = YAML.load_file(@project.metadata_filename)
      end
    end


    def phase_2_read_options
      @project.options = build_options
    end


    def phase_2_read_outline
      if @validator.validate_file_outline
        @project.outline = build_outline
      end
    end


    def phase_3_set_javascript_libraries_requested
      @project.javascript_libraries_requested = determine_javascript_libraries
    end


    def phase_3_set_metadata_instance_date
      @project.metadata["date of this edition"] = @project.instance_date
    end


    def phase_4_validate
      @validator.validate_dir_compiled
      @validator.validate_file_css
      @validator.validate_option_remote_publish
      @validator.validate_option_remote_sync
      @validator.validate_output_destination_and_formats
      @validator.validate_scenario_if_more_than_one_document
    end


    def phase_5_build_manifest
      @project.manifest = build_manifest
    end



    private


    def build_manifest
      ManifestBuilder.build do |b|
        b.build_from_project(@project)
      end
    end


    def build_options
      ProjectOptionsReader.build do |b|
        b.build_from_ymlfile(@project)
      end
    end


    def build_outline
      outline = YAML.load_stream(File.read(@project.outline_filename))
      outline.reject!{ |step| NilClass === step }
      outline.each_with_index do |document, index|
        if document_outline_does_not_begin_with_known_directive(document)
          outline[index] = presume_text_block(document)
        end
      end
      outline
    end


    def determine_javascript_libraries
      libraries = []
      if @project.options.html_uses_javascript_navigation
        libraries << :navigation
      end
      if libraries.count > 0
        libraries.unshift(:init)
      end
      libraries
    end


    def document_outline_does_not_begin_with_known_directive(document)
      OutlineHelper.type_of(document[0]) == nil
    end


    def presume_text_block(document)
      [{'Text' => document}]
    end


  end
end
