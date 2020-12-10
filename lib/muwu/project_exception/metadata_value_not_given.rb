module Muwu
  module ProjectException
    class MetadataValueNotGiven
      
      
      include Muwu
   
   
      def initialize(task, key)
        @task = task
        @index = task.document_index
        @key = key
      end
      
      
      def report
        "Metadata value for `#{@key}` not found (document #{@index}, block `#{block_type}`)."
      end
      
      
      def type
        :warning
      end
      
      
      
      private
      
      
      def block_type
        case @task
        when ManifestTask::Metadata
          'metadata'
        when ManifestTask::Title
          'title'
        end
      end
      
      
    end
  end
end