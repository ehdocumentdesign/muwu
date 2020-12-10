module Muwu
  class ManifestBuilder


    include Muwu
    

    attr_accessor(
      :manifest,
      :project
    )
  

    def self.build
      builder = new
      yield(builder)
      builder.manifest
    end


    def initialize
      @manifest = Manifest.new
    end


    def build_from_project(project)
      @project = project
      set_documents
      set_project
    end
  
  
    def set_documents
      @manifest.documents = determine_documents
    end


    def set_project
      @manifest.project = @project
    end
    


    private


    def build_document_css
      ManifestTaskBuilders::DocumentCssBuilder.build do |b|
        b.build_document(@project)
      end
    end


    def build_document_html(index, outline_fragment_document)
      ManifestTaskBuilders::DocumentHtmlBuilder.build do |b|
        b.build_document(@project, index, outline_fragment_document)
      end
    end
  

    def build_document_js
      ManifestTaskBuilders::DocumentJsBuilder.build do |b|
        b.build_document(@project)
      end
    end


    def determine_documents
      documents = []
      documents << determine_documents_html
      documents << determine_documents_js
      documents << determine_documents_css
      documents.compact!
      documents.flatten
    end
    
    
    def determine_documents_css
      if @project.will_create_css_file
        build_document_css
      end
    end
    
    
    def determine_documents_js
      if @project.will_create_javascript_file
        build_document_js
      end
    end
        
    
    def determine_documents_html
      documents = []      
      @project.outlined_documents_by_index.each_pair do |index, contents|
        documents << build_document_html(index, contents)
      end
      documents
    end
    
  
  end
end
