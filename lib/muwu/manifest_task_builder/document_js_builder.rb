module Muwu
  module ManifestTaskBuilders
    class DocumentJsBuilder


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
        @document = ManifestTask::DocumentJs.new
      end


      def build_document(project)
        depends_on_project(project)
        set_destination
        set_libraries
        set_project
      end


      def depends_on_project(project)
        @project = project
      end


      def set_destination
        @document.destination = build_destination
      end
  

      def set_libraries
        @document.libraries = @project.javascript_libraries_requested
      end
    
    
      def set_project
        @document.project = @project
      end
  


      private


      def build_destination
        DestinationBuilder.build do |b|
          b.build_js(@project)
        end
      end
    

    end
  end
end