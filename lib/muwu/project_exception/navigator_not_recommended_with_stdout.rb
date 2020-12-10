module Muwu
  module ProjectException
    class NavigatorNotRecommendedWithSingleDocument
   
   
      def initialize(index)
        @index = index
      end
      
      
      def report
        "Navigator not recommended with a single outlined document."
      end
      
      
      def type
        :warning
      end
      
      
    end
  end
end