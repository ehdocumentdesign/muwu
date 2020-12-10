module Muwu
  module ManifestTaskBuilders
    class SubcontentsBuilder


      include Muwu
      include Helper
      

      attr_accessor(
        :manifest_subcontents,
        :outline_subcontents,
        :parent_document,
        :project
      )


      def self.build
        builder = new
        yield(builder)
        builder.manifest_subcontents
      end


      def initialize
        @manifest_subcontents = ManifestTask::Subcontents.new
      end


      def build_from_document(outline_step, parent_document)
        @outline_subcontents = outline_step
        @parent_document = parent_document
        @project = parent_document.project
        phase_1_set_parent
        phase_1_set_project
        phase_2_set_destination
        phase_2_set_text_root_name
        phase_3_set_item_depth_max
        phase_3_set_will_render_section_numbers
      end


      def phase_1_set_parent
        @manifest_subcontents.parent = @parent_document
      end

  
      def phase_1_set_project
        @manifest_subcontents.project = @project
      end


      def phase_2_set_destination
        @manifest_subcontents.destination = @parent_document.destination
      end
      
      
      def phase_2_set_text_root_name
        @manifest_subcontents.text_root_name = determine_text_root_name
      end
      
      
      def phase_3_set_item_depth_max
        @manifest_subcontents.item_depth_max = @project.options.render_sections_distinctly_depth_max
      end
      

      def phase_3_set_will_render_section_numbers
        @manifest_subcontents.will_render_section_numbers = @project.options.render_section_numbers
      end
  


      private


      def determine_text_root_name
        components = @outline_subcontents.partition(RegexpLib.outline_text_plus_whitespace)
        text_block_name = components[2].to_s.downcase.strip
        if text_block_name == ''
          text_block_name = @project.default_text_block_name
        end
        text_block_name
      end
      
  
      
    end
  end
end
