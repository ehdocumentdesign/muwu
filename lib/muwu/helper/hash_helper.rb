module Muwu
  module Helper
    module HashHelper


      module_function
      
      
      def human_readable_hash(incoming_hash)
        result_hash = {}
        incoming_hash.each_pair do |k, v|
          key = human_readable_key(k)
          value = human_readable_value(v)
          result_hash[key] = value
        end
        result_hash
      end
      
      
      def human_readable_key(k)
        k.to_s.gsub(/\A:/,'')
      end
      
      
      def human_readable_value(v)
        case v
        when Array
          return v.join(', ')
        else
          return v
        end
      end

    
    end
  end  
end
