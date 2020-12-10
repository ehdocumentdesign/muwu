module Muwu
  module ProjectException
    class DryOutputRecommendedWithMultipleDocuments
      
      
      def report
        "Shared assets will be embedded. Including `css` and `js` in `output_formats` is recommended with multiple documents."
      end
      
      
      def type
        :warning
      end
      
      
    end
  end
end
        