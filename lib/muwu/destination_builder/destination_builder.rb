module Muwu
  class DestinationBuilder


    include Muwu


    attr_accessor(
      :destination,
      :project
    )


    def self.build
      builder = new
      yield(builder)
      builder.destination
    end


    def initialize
      @destination = Destination.new
    end


    def build_css(project)
      depends_on_project(project)
      set_output_class
      set_output_filename_css
      set_output_working_directory
    end


    def build_html(project, index)
      depends_on_project(project)
      set_output_class
      set_output_filename_html(index)
      set_output_working_directory
    end


    def build_js(project)
      depends_on_project(project)
      set_output_class
      set_output_filename_js
      set_output_working_directory
    end


    def depends_on_project(project)
      @project = project
    end


    def set_output_class
      @destination.output_class = @project.output_destination
    end


    def set_output_filename_css
      if @destination.output_class == 'file'
        @destination.output_filename = determine_output_filename_css
      end
    end


    def set_output_filename_html(index)
      if @destination.output_class == 'file'
        @destination.output_filename = determine_output_filename_html(index)
      end
    end


    def set_output_filename_js
      if @destination.output_class == 'file'
        @destination.output_filename = determine_output_filename_js
      end
    end


    def set_output_working_directory
      if @destination.output_class == 'file'
        @destination.output_working_directory = @project.path_compiled
      end
    end



    private


    def determine_output_filename_css
      filename = ''
      filename.concat @project.css_basename
      filename.concat ".css"
      filename
    end


    def determine_output_filename_html(index)
      filename = ''
      filename.concat @project.html_basename
      if index_is_integer_greater_than_zero(index)
        filename.concat "_#{index}"
      end
      filename.concat ".html"
      filename
    end


    def determine_output_filename_js
      filename = ''
      filename.concat @project.js_basename
      filename.concat ".js"
      filename
    end


    def index_is_integer_greater_than_zero(index)
      (Integer === index) && (index >= 1)
    end


  end
end
