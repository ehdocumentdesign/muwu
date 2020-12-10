module Muwu
  module RenderHtmlPartialBuilder
    class MetadataBuilder


      include Muwu
      include Helper


      attr_accessor(
        :manifest_metadata,
        :renderer
      )


      def self.build
        builder = new
        yield(builder)
        builder.renderer
      end


      def initialize
        @renderer = RenderHtmlPartial::Metadata.new
      end


      def build_from_manifest_metadata(metadata)
        @metadata = metadata
        set_destination
        set_metadata
      end


      def set_destination
        @renderer.destination = @metadata.destination
      end


      def set_metadata
        @renderer.metadata = SanitizerHelper.sanitize_metadata(@metadata.metadata)
      end


    end
  end
end
