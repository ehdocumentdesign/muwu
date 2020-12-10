module Muwu
  module ManifestTaskBuilders
    class DocumentHtmlBuilder
      

      include Muwu
      include Helper


      attr_accessor(
        :document,
        :index,
        :outline,
        :project,
        :validator
      )


      def self.build
        builder = new
        yield(builder)
        builder.document
      end


      def initialize
        @document = ManifestTask::DocumentHtml.new
      end


      def build_document(project, index, outline_fragment_document)
        @index = index
        @outline = outline_fragment_document
        @project = project
        @validator = ProjectValidator.new(@project)
        set_destination
        set_index
        set_css_filename_and_include_method
        set_js_filename_and_include_method
        set_js_libraries
        set_project
        set_tasks
      end
      
        
      def set_css_filename_and_include_method
        if @project.will_create_css_file
          @document.css_filename = @project.css_basename + '.css'
          @document.css_include_method = :link
        else
          @document.css_include_method = :embed
        end
      end
    
    
      def set_destination
        @document.destination = build_destination
      end
    
    
      def set_index
        @document.index = @index
      end
  

      def set_js_filename_and_include_method
        if @project.will_require_javascript_libraries 
          if @project.will_create_javascript_file
            @document.js_filename = @project.js_basename + '.js'
            @document.js_include_method = :link
          else
            @document.js_include_method = :embed
          end
        else
          @document.js_include_method = :none
        end
      end
    
    
      def set_js_libraries
        if @document.js_include_method == :embed
          @document.js_head_libraries = @project.javascript_libraries_requested
        end
      end


      def set_project
        @document.project = @project
      end


      def set_tasks
        @document.tasks = determine_tasks
        generate_subcontents_per_options
        generate_navigators_per_options
      end
            


      private


      def build_destination
        DestinationBuilder.build do |b|
          b.build_html(@project, @index)
        end
      end
    

      def build_task_contents(outline_step)
        ManifestTaskBuilders::ContentsBuilder.build do |b|
          b.build_from_outline(outline_step, @document)
        end
      end


      def build_task_metadata(outline_step)
        ManifestTaskBuilders::MetadataBuilder.build do |b|
          b.build_from_outline(outline_step, @document)
        end
      end


      def build_task_navigator
        ManifestTaskBuilders::NavigatorBuilder.build do |b|
          b.build_from_outline(@document)
        end
      end


      def build_task_subcontents(outline_step: 'subcontents')
        ManifestTaskBuilders::SubcontentsBuilder.build do |b|
          b.build_from_document(outline_step, @document)
        end
      end


      def build_task_text(outline_step)
        ManifestTaskBuilders::TextBuilder.build do |b|
          b.build_from_outline(outline_step, @document)
        end
      end


      def build_task_title(outline_step)
        ManifestTaskBuilders::TitleBuilder.build do |b|
          b.build_from_outline(outline_step, @document)
        end
      end


      def determine_tasks
        tasks = []
        @outline.each do |step|
          
          case OutlineHelper.type_of(step)
          when :contents
            tasks << build_task_contents(step)
            
          when :metadata
            tasks << build_task_metadata(step)
            
          when :navigator
            if @validator.validate_outline_step_navigator(@index)
              tasks << build_task_navigator
            end
            
          when :subcontents
            if @validator.validate_outline_step_subcontents(@index)
              tasks << build_task_subcontents(outline_step: step)
            end
            
          when :text
            tasks << build_task_text(step)
            
          when :title
            tasks << build_task_title(step)
            
          else
            @project.exceptions_add ProjectException::OutlineStepNotUnderstood.new(step)

          end
        end
        tasks
      end
      
      
      def generate_navigators_per_options
        if @project.will_generate_navigators_automatically
          @document.tasks.prepend(build_task_navigator)
          @document.tasks.append(build_task_navigator)
        end
      end
      
      
      def generate_subcontents_per_options
        if @document.will_generate_subcontents_automatically
          @document.tasks.prepend(build_task_subcontents)
        end
      end
      
      
      def outline_fragment_includes_navigator
        OutlineHelper.new(@outline).includes_navigator
      end


    end
  end
end