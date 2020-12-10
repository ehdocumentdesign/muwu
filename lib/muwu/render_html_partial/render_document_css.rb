module Muwu
  module RenderHtmlPartial
    class DocumentCss

      
      include Muwu
      
      
      require 'sassc'

  
      attr_accessor( 
        :destination,
        :project,
      )


      def render
        @destination.output_stream do
          if @project.exceptions_include?(ProjectException::CssManifestFileNotFound)
            write_css_missing_comment
          else
            write_css
          end
        end
      end
      
  
      def write_css_missing_comment
        @destination.write_line "/*"
        @destination.write_line "#{ProjectException::CssManifestFileNotFound}"
        @destination.write_line "  - CSS manifest file could not be found."
        @destination.write_line "  - Expecting `#{project.css_manifest_filename}`"
        @destination.write_line "*/"
      end
      
      
      def write_css
        @destination.write_inline SassC::Engine.new(File.read(@project.css_manifest_filename), syntax: :scss, load_paths: ['config/css']).render
      end      


    end
  end
end
