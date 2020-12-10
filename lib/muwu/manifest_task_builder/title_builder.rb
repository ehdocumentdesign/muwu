module Muwu
  module ManifestTaskBuilders
    class TitleBuilder
      

      include Muwu
      include Helper
      
      
      attr_accessor(
        :outline_fragment_title,
        :parent_document,
        :project,
        :task
      )


      def self.build
        builder = new
        yield(builder)
        builder.task
      end


      def initialize
        @task = ManifestTask::Title.new
      end


      def build_from_outline(outline_fragment_title, parent_document)
        @destination = parent_document.destination
        @outline_fragment_title = outline_fragment_title
        @parent_document = parent_document
        @project = parent_document.project
        phase_1_set_parent
        phase_1_set_project
        phase_2_set_destination
        phase_2_set_metadata
        phase_3_validate_metadata_values_exist
      end

  
      def phase_1_set_parent
        @task.parent_document = @parent_document
      end
  

      def phase_1_set_project
        @task.project = @project
      end


      def phase_2_set_destination
        @task.destination = @destination
      end


      def phase_2_set_metadata
        @task.metadata = determine_metadata
      end
      
      
      def phase_3_validate_metadata_values_exist
        ProjectValidator.new(@project).validate_task_title(@task)
      end
        
  

      private

  
      def determine_metadata
        case @outline_fragment_title
        when Hash
          determine_metadata_selected
        when String
          determine_metadata_default
        end
      end
      
      
      def determine_metadata_default
        metadata = {}
        @project.options.render_title_section_metadata.each do |key|
          metadata[key] = @project.metadata[key]
        end
        metadata
      end
      
      
      def determine_metadata_selected
        metadata = {}
        keys = @outline_fragment_title.flatten[1]
        keys.each do |key|
          if key =~ RegexpLib.metadata_key_date_of_this_edition
            metadata.merge!(determine_metadata_date_of_this_edition(key: key))
          else
            metadata.merge!(determine_metadata_selected_and_validate(key))
          end
        end
        metadata
      end
      
      
      def determine_metadata_selected_and_validate(key)
        metadata = @project.metadata.select { |k,v| k.downcase == key.downcase }
        if metadata.empty?
          metadata = {key => nil}
        end
        metadata
      end
      
      
      def determine_metadata_date_of_this_edition(key: 'date of this edition')
        metadata = {key => @project.metadata["date of this edition"]}
        metadata
      end
  
    
    end
  end
end
