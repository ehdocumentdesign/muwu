module Muwu
  class RenderHtmlBuilder


    include Muwu


    def initialize(document)
      @document = document
    end
    
      
    def build_and_render
      if ManifestTask::DocumentHtml === @document
        build_document_html.render
      end
    end
  
  

    private
  
    
    def build_document_html
      RenderHtmlPartialBuilder::DocumentHtmlBuilder.build do |b|
        b.build_from_manifest_document(@document)
      end
    end


  end
end

  