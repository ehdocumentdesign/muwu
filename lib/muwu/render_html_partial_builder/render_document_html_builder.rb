module Muwu
  module RenderHtmlPartialBuilder
    class DocumentHtmlBuilder


      include Muwu
      include Helper

      
      attr_accessor(
        :renderer
      )


      def self.build
        builder = new
        yield(builder)
        builder.renderer
      end


      def initialize
        @renderer = RenderHtmlPartial::DocumentHtml.new
      end


      def build_from_manifest_document(document)
        @document = document
        @project = document.project
        set_destination
        set_html_lang
        set_html_title
        set_head_css_method
        set_head_js_libraries
        set_head_js_method
        set_head_includes_metadata_tags
        set_head_metadata
        set_project
        set_tasks
        finally_set_css_filename
        finally_set_js_filename
      end


      def finally_set_css_filename
        if @renderer.head_css_method == :link
          @renderer.head_css_filename = @document.css_filename
        end
      end
  

      def finally_set_js_filename
        if @renderer.head_js_method == :link
          @renderer.head_js_filename = @document.js_filename
        end
      end


      def set_destination
        @renderer.destination = @document.destination
      end
      
      
      def set_html_lang
        @renderer.html_lang = @project.options.html_lang
      end


      def set_html_title
        @renderer.html_title = determine_html_title
      end


      def set_head_includes_metadata_tags
        @renderer.head_includes_metadata_tags = @project.options.html_head_includes_metadata_tags
      end
      
      
      def set_head_metadata
        if @project.options.html_head_includes_metadata_tags
          @renderer.head_metadata = SanitizerHelper::sanitize_metadata(@project.metadata)
        end
      end


      def set_head_css_method
        @renderer.head_css_method = @document.css_include_method
      end


      def set_head_js_libraries
        @renderer.head_js_libraries = @document.js_head_libraries
      end
      
      
      def set_head_js_method
        @renderer.head_js_method = @document.js_include_method
      end


      def set_project
        @renderer.project = @project
      end


      def set_tasks
        @renderer.tasks = determine_document_tasks
      end



      private


      def build_contents(task)
        RenderHtmlPartialBuilder::ContentsBuilder.build do |b|
          b.build_from_manifest_task_contents(task)
        end
      end


      def build_metadata(task)
        RenderHtmlPartialBuilder::MetadataBuilder.build do |b|
          b.build_from_manifest_metadata(task)
        end
      end


      def build_navigator(task)
        RenderHtmlPartialBuilder::NavigatorBuilder.build do |b|
          b.build_from_manifest_task_navigator(task)
        end
      end
      
      
      def build_subcontents(task)
        RenderHtmlPartialBuilder::SubcontentsBuilder.build do |b|
          b.build_from_manifest_task_subcontents(task)
        end
      end


      def build_text(task)
        RenderHtmlPartialBuilder::TextBuilder.build do |b|
          b.build_from_manifest_text(task)
        end
      end


      def build_title(task)
        RenderHtmlPartialBuilder::TitleBuilder.build do |b|
          b.build_from_manifest_title(task)
        end
      end


      def determine_document_tasks
        tasks = []
        @document.tasks.each do |task|
          case task
          when ManifestTask::Contents
            tasks << build_contents(task)
            
          when ManifestTask::Metadata
            tasks << build_metadata(task)
            
          when ManifestTask::Navigator
            tasks << build_navigator(task)
            
          when ManifestTask::Subcontents
            tasks << build_subcontents(task)
            
          when ManifestTask::Text
            tasks << build_text(task)
            
          when ManifestTask::Title
            tasks << build_title(task)
          end
        end
        tasks
      end
      
            
      def determine_html_title
        if @project.manifest.documents_html_count == 1
          determine_html_title_single_document
        elsif @project.manifest.documents_html_count > 1
          determine_html_title_multiple_documents
        end
      end
      
      
      def determine_html_title_multiple_documents
        if @document.index == 0
          return @project.title
        elsif @document.index > 0
          project_title = @project.title
          page_current = @document.index + 1
          page_last = @project.manifest.documents_html_count
          return "#{project_title} - page #{page_current} of #{page_last}"
        end
      end
      
      def determine_html_title_single_document
        @project.title
      end


    end
  end
end
