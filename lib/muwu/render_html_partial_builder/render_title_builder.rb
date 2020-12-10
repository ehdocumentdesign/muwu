module Muwu
  module RenderHtmlPartialBuilder
    class TitleBuilder


      include Muwu
      include Helper
      

      attr_accessor(
        :manifest_title,
        :renderer
      )


      def self.build
        builder = new
        yield(builder)
        builder.renderer
      end


      def initialize
        @renderer = RenderHtmlPartial::Title.new
      end


      def build_from_manifest_title(manifest_title)
        @manifest_title = manifest_title
        set_destination
        set_metadata
      end


      def set_destination
        @renderer.destination = @manifest_title.destination
      end


      def set_metadata
        @renderer.metadata = SanitizerHelper::sanitize_metadata(@manifest_title.metadata)
      end
      

    end
  end
end
