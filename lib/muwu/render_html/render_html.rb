module Muwu
  class RenderHtml


    require 'fileutils'


    include Muwu


    def initialize(project)
      @manifest = project.manifest
      @project = project
      halt_if_project_has_fatal_exceptions
    end



    public


    def render_all
      if @manifest.does_have_documents
        build_and_render(@manifest.documents)
      else
        reply_nothing_to_do
      end
    end


    def render_css_only
      if @manifest.does_have_documents_css
        build_and_render(@manifest.documents_css)
      else
        reply_nothing_to_do
      end
    end


    def render_html_by_index(index)
      document_html = @manifest.find_document_html_by_index(index)
      if document_html
        build_and_render(document_html)
      else
        reply_nothing_to_do
      end
    end


    def render_html_only
      if @manifest.does_have_documents_html
        build_and_render(@manifest.documents_html)
      else
        reply_nothing_to_do
      end
    end


    def render_js_only
      if @manifest.does_have_documents_js
        build_and_render(@manifest.documents_js)
      else
        reply_nothing_to_do
      end
    end



    private


    def build_and_render(document)
      case document
      when Array
        document.each { |d| build_and_render(d) }

      when ManifestTask::DocumentCss
        RenderCssBuilder.new(document).build_and_render

      when ManifestTask::DocumentHtml
        RenderHtmlBuilder.new(document).build_and_render

      when ManifestTask::DocumentJs
        RenderJsBuilder.new(document).build_and_render
      end
    end


    def halt_if_project_has_fatal_exceptions
      begin
        if @project.exceptions_fatal.any?
          raise ProjectExceptionHandler::Fatal.new(@project.exceptions_fatal)
        end
      end
    end


    def reply_nothing_to_do
      $stderr.puts '- No documents to compile.'
    end


  end
end
