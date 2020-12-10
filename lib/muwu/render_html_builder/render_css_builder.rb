module Muwu
  class RenderCssBuilder


    include Muwu


    def initialize(document)
      @document = document
    end
    
      
    def build_and_render
      if ManifestTask::DocumentCss === @document
        build_document_css.render
      end
    end
  
  
  
    private
  
    
    def build_document_css
      RenderHtmlPartialBuilder::DocumentCssBuilder.build do |b|
        b.build_from_manifest_document(@document)
      end
    end
  

  end
end

  