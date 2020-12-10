module Muwu
  module RenderHtmlPartialBuilder
    class NavigatorBuilder
   
      
      include Muwu
      
      
      attr_accessor(
        :project,
        :renderer
      )
      
      
      def self.build
        builder = new
        yield(builder)
        builder.renderer
      end
      
      
      def initialize
        @renderer = RenderHtmlPartial::Navigator.new
      end
      
      
      def build_from_manifest_task_navigator(navigator)
        @navigator = navigator
        @project = navigator.project
        set_destination
        set_heading
        set_href_document_home
        set_href_document_next
        set_href_document_prev
      end
   
   
      def set_destination
        @renderer.destination = @navigator.destination
      end
      
      
      def set_heading
        @renderer.heading = @navigator.heading
      end
      
      
      def set_href_document_home
        @renderer.href_document_home  = determine_href_by_index(@navigator.document_home_index)
      end
      

      def set_href_document_next
        @renderer.href_document_next  = determine_href_by_index(@navigator.document_next_index)
      end
      

      def set_href_document_prev
        @renderer.href_document_prev  = determine_href_by_index(@navigator.document_prev_index)
      end
      
      
      
      private
      
      
      def determine_href_by_index(index)
        @project.manifest.find_document_html_by_index(index).destination.output_filename
      end
      

    end
  end
end