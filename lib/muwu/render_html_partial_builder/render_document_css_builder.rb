module Muwu
  module RenderHtmlPartialBuilder
    class DocumentCssBuilder

      
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
        @renderer = RenderHtmlPartial::DocumentCss.new
      end


      def build_from_manifest_document(document)
        @document = document
        @project = document.project
        set_destination
        set_project
      end


      def set_destination
        @renderer.destination = @document.destination
      end


      def set_project
        @renderer.project = @project
      end


    end
  end
end
