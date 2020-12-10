module Muwu
  module RenderHtmlPartial
    class DocumentJs

  
      include Muwu
        

      attr_accessor( 
        :destination,
        :libraries,
        :project
      )


      def render
        @destination.output_stream do
          libraries.each do |library|
            write_library(library)
          end
        end
      end


      def options
        @project.options
      end
      
      
      def write_library(library)
        @destination.write_inline RenderHtmlPartial::JsLibrary.new.find(library)
      end  


    end
  end
end
