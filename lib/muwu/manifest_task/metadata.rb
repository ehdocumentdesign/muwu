module Muwu
  module ManifestTask
    class Metadata
  
  
      attr_accessor(
        :destination, 
        :metadata,
        :parent_document,
        :project
      )
      
      
      def inspect
        ["#{self.to_s}", "{", inspect_instance_variables, "}"].join(' ')
      end


      def inspect_instance_variables
        self.instance_variables.map { |v| "#{v}=#<#{instance_variable_get(v).class}>" }.join(", ")
      end          



      public
      
      
      def document_index
        @parent_document.index
      end


    end
  end
end
