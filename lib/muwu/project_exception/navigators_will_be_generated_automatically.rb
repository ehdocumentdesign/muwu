module Muwu
  module ProjectException
    class NavigatorsWillBeGeneratedAutomatically
   
   
      def initialize(index)
        @index = index
      end
      
      
      def report
        "Navigators will be generated automatically. Ignoring outline directive (document #{@index})."
      end
      
      
      def type
        :warning
      end
      
      
    end
  end
end