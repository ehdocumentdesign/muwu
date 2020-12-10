module Muwu
  module RenderHtmlPartialBuilder
    class DocumentJsBuilder

      
      include Muwu


      attr_accessor(
        :renderer
      )


      def self.build
        builder = new
        yield(builder)
        builder.renderer
      end


      def initialize
        @renderer = RenderHtmlPartial::DocumentJs.new
      end


      def build_from_manifest_document(document)
        @document = document
        @project = document.project
        set_destination
        set_libraries
        set_project
      end


      def set_destination
        @renderer.destination = @document.destination
      end
      
      
      def set_libraries
        @renderer.libraries = @project.javascript_libraries_requested
      end


      def set_project
        @renderer.project = @project
      end


    end
  end
end
