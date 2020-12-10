module Muwu
  module RenderHtmlPartial
    class JsLibrary
      
      
      include Muwu

    
      def initialize
        js_lib_folder = File.join(File.dirname(__FILE__), 'js_library')
        @js_lib_path = File.absolute_path(js_lib_folder)
      end
      
      
      public
            
    
      def file_init
        read_js_lib_file('init.js')
      end
    
    
      def file_navigation
        read_js_lib_file('navigation.js')
      end
      
      
      def find(symbol)
        case symbol
        when :init
          file_init
        when :navigation
          file_navigation
        end
      end
    
    
    
      private
    
    
      def js_lib_filepath_to(filename)
        File.absolute_path(File.join(@js_lib_path, filename))
      end
    
    
      def read_js_lib_file(filename)
        File.read(js_lib_filepath_to(filename))
      end
    
    
    end
  end
end
