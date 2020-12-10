module Muwu
  module ManifestTaskBuilders
    class NavigatorBuilder
      
      
      include Muwu
      
      
      attr_accessor(
        :document,
        :navigator,
        :outline_step,
        :project
      )

      def self.build
        builder = new
        yield(builder)
        builder.navigator
      end
      
      
      def initialize
        @navigator = ManifestTask::Navigator.new
      end
      
      
      def build_from_outline(document)
        @document = document
        @project = document.project
        set_destination
        set_document_home_index
        set_document_next_index
        set_document_prev_index
        set_heading
        set_index
        set_project
      end
      
      
      def set_destination
        @navigator.destination = @document.destination
      end
      
      
      def set_document_home_index
        @navigator.document_home_index = 0
      end
      
      
      def set_document_next_index
        @navigator.document_next_index = (@document.index + 1) % @project.outline.length
      end


      def set_document_prev_index
        @navigator.document_prev_index = (@document.index - 1) % @project.outline.length
      end
      
      
      def set_heading
        @navigator.heading = @project.title
      end
            
      
      def set_index
        @navigator.index = @document.index
      end
      
      
      def set_project
        @navigator.project = @project
      end
      
      
    end
  end
end