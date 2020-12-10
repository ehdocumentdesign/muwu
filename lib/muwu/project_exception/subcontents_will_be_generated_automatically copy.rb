module Muwu
  module ProjectException
    class SubcontentsWillBeGeneratedAutomatically
   
   
      def initialize(index)
        @index = index
      end
      
      
      def report
        "Subcontents will be generated automatically. Ignoring outline directive (document #{@index})."
      end
      
      
      def type
        :warning
      end
      
      
    end
  end
end