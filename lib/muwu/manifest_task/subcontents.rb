module Muwu
  module ManifestTask
    class Subcontents


      attr_accessor(
        :destination,
        :item_depth_max,
        :parent,
        :project,
        :section_number_max_depth,
        :text_root_name,
        :will_render_section_numbers      
      )
      
      
      def inspect
        ["#{self.to_s}", "{", inspect_instance_variables, "}"].join(' ')
      end


      def inspect_instance_variables
        self.instance_variables.map { |v| "#{v}=#<#{instance_variable_get(v).class}>" }.join(", ")
      end    
      
      
      
      public
  
      
      def document
        @parent
      end
      
        
      def naming
        [@text_root_name]
      end
      
      
      def text_root_blocks
        document.text_blocks_by_name(@text_root_name)
      end


    end
  end
end
