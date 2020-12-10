module Muwu
  module ManifestTask
    class Contents


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
  
  
      def naming
        [@text_root_name]
      end
  

      def text_blocks_by_name(name)
        @project.manifest.text_blocks_by_name(name)
      end


    end
  end
end
