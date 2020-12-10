module Muwu
  module ManifestTask
    class DocumentCss


      attr_accessor(
        :destination,
        :libraries,
        :project
      )
      
      
      def filename
        @destination.output_filename
      end
      
      
      def inspect
        ["#{self.to_s}", "{", inspect_instance_variables, "}"].join(' ')
      end


      def inspect_instance_variables
        self.instance_variables.map { |v| "#{v}=#<#{instance_variable_get(v).class}>" }.join(", ")
      end    
          
  
    end
  end
end
