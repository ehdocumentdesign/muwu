module Muwu
  class RenderJsBuilder


    include Muwu


    def initialize(document)
      @document = document
    end
    
      
    def build_and_render
      if ManifestTask::DocumentJs === @document
        build_document_js.render
      end
    end
  
  
  
    private
  

    def build_document_js
      RenderHtmlPartialBuilder::DocumentJsBuilder.build do |b|
        b.build_from_manifest_document(@document)
      end
    end      


  end
end

  