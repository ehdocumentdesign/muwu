module Muwu
  module ManifestTaskBuilders
    class DocumentCssBuilder


      include Muwu
  

      attr_accessor(
        :document,
        :outline,
        :project
      )


      def self.build
        builder = new
        yield(builder)
        builder.document
      end


      def initialize
        @document = ManifestTask::DocumentCss.new
      end


      def build_document(project)
        depends_on_project(project)
        set_destination
        set_project
      end


      def depends_on_project(project)
        @project = project
      end
  
  
      def set_destination
        @document.destination = build_destination
      end
    
          
      def set_project
        @document.project = @project
      end
    
  
  
      private


      def build_destination
        DestinationBuilder.build do |b|
          b.build_css(@project)
        end
      end
      

    end
  end
end
