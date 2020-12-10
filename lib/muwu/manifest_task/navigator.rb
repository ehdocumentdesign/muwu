module Muwu
  module ManifestTask
    class Navigator
      
      
      attr_accessor(
        :destination,
        :document_home_index,
        :document_next_index,
        :document_prev_index,
        :heading,
        :index,
        :project
      )
      
      
      def inspect
        ["#{self.to_s}", "{", inspect_instance_variables, "}"].join(' ')
      end


      def inspect_instance_variables
        self.instance_variables.map { |v| "#{v}=#<#{instance_variable_get(v).class}>" }.join(", ")
      end    
   
      
    end
  end
end