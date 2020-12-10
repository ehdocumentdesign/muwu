module Muwu
  module RenderHtmlPartialBuilder
    class TextItemBuilder


      include Muwu


      attr_accessor(
        :renderer
      )


      def self.build
        builder = new
        yield(builder)
        builder.renderer
      end


      def initialize
        @renderer = RenderHtmlPartial::TextItem.new
      end


      def build_from_manifest_text_item(manifest_text_item)
        @manifest_text_item = manifest_text_item
        @project = manifest_text_item.project
        @href_helper = Helper::HtmlHrefHelper.new(manifest_text_item)
        phase_1_set_destination
        phase_1_set_heading
        phase_1_set_heading_origin
        phase_1_set_numbering
        phase_1_set_section_depth
        phase_1_set_section_number_as_attr
        phase_1_set_section_number_as_text
        phase_1_set_does_have_source_text
        phase_1_set_is_parent_heading
        phase_1_set_text_root_name
        phase_1_set_markdown_renderer
        phase_2_set_source_filename_absolute
        phase_2_set_source_filename_relative
        phase_3_set_sections
        phase_4_set_end_links
        phase_4_set_html_attr_id
        phase_4_set_will_render_section_number
        phase_4_set_subsections_are_distinct
      end



      def phase_1_set_destination
        @renderer.destination = @manifest_text_item.destination
      end
      
      
      def phase_1_set_does_have_source_text
        if @manifest_text_item.source_file_does_exist
          @renderer.does_have_source_text = true
        elsif @manifest_text_item.source_file_does_not_exist
          @renderer.does_have_source_text = false
        end
      end
      
      
      def phase_1_set_heading
        @renderer.heading = @manifest_text_item.heading
      end


      def phase_1_set_heading_origin
        @renderer.heading_origin = @manifest_text_item.heading_origin
      end
      
      
      def phase_1_set_is_parent_heading
        @renderer.is_parent_heading = @manifest_text_item.is_parent_heading
      end
      
      
      def phase_1_set_markdown_renderer
        @renderer.markup_renderer = Muwu::RenderMarkupToHtml.new(@project)
      end


      def phase_1_set_numbering
        @renderer.numbering = @manifest_text_item.numbering
      end
      
      
      def phase_1_set_options_commonmarker
        @renderer.options_commonmarker = []
        if @project.options.render_punctuation_smart
          @renderer.options_commonmarker.append(:SMART)
        end
      end


      def phase_1_set_section_depth
        @renderer.section_depth = @manifest_text_item.section_depth
      end


      def phase_1_set_section_number_as_attr
        @renderer.section_number_as_attr = @manifest_text_item.numbering.join('_')
      end


      def phase_1_set_section_number_as_text
        @renderer.section_number_as_text = @manifest_text_item.numbering.join('.')
      end


      def phase_1_set_text_root_name
        @renderer.text_root_name = @manifest_text_item.text_root_name
      end


      def phase_2_set_source_filename_absolute
        if @manifest_text_item.source_file_does_exist
          @renderer.source_filename_absolute = @manifest_text_item.source_filename_absolute
        end
      end


      def phase_2_set_source_filename_relative
        if @manifest_text_item.source_file_does_exist
          @renderer.source_filename_relative = @manifest_text_item.source_filename_relative
        end
      end


      def phase_3_set_sections
        if @manifest_text_item.does_have_child_sections
          @renderer.sections = determine_sections
        end
      end
      
      
      def phase_4_set_end_links
        if text_item_should_have_end_links
          @renderer.end_links = determine_end_links
        end
      end


      def phase_4_set_html_attr_id
        @renderer.html_attr_id = ['text', @renderer.text_root_name, @renderer.section_number_as_attr].join('_')
      end
      
      
      def phase_4_set_will_render_section_number
        @renderer.will_render_section_number = determine_whether_text_item_will_render_section_number
      end
      
      
      def phase_4_set_subsections_are_distinct
        @renderer.subsections_are_distinct = determine_whether_subsections_are_distinct
      end



      private


      def build_renderer_text_item(text_item)
        RenderHtmlPartialBuilder::TextItemBuilder.build do |b|
          b.build_from_manifest_text_item(text_item)
        end
      end


      def determine_end_links
        end_links = {}
        if @project.options.render_section_end_links   
          @project.options.render_section_end_links.each do |link|
            end_links[link] = determine_end_links_href(link)
          end
        end
        end_links
      end


      def determine_end_links_href(link)
        case link
        when 'contents'
          @href_helper.to_contents_heading(@manifest_text_item)
        when 'home'
          @href_helper.to_project_home
        when 'top'
          @href_helper.to_document_top
        end
      end
      

      def determine_sections
        sections = []
        @manifest_text_item.sections.each do |section|
          sections << build_renderer_text_item(section)
        end
        sections
      end


      def determine_whether_subsections_are_distinct
        if @manifest_text_item.does_have_child_sections
          if @project.options.render_sections_distinctly_depth_max == nil
            return true
          elsif @renderer.section_depth < @project.options.render_sections_distinctly_depth_max
            return true
          elsif @renderer.section_depth >= @project.options.render_sections_distinctly_depth_max
            return false
          end
        end
      end


      def determine_whether_text_item_will_render_section_number
        if @project.will_render_section_numbers && text_item_should_be_distinct
          true
        end
      end
      

      def text_item_should_be_distinct
        if @project.options.render_sections_distinctly_depth_max == nil
          return true
        elsif @renderer.section_depth <= @project.options.render_sections_distinctly_depth_max
          return true
        elsif @renderer.section_depth > @project.options.render_sections_distinctly_depth_max
          return false
        end
      end
      
      
      def text_item_should_have_end_links
        if text_item_should_be_distinct
          return text_item_distinct_should_have_end_links
        else
          return false
        end
      end
      
          
      def text_item_distinct_should_have_end_links
        if @renderer.is_parent_heading
          return text_item_distinct_parent_should_have_end_links
        elsif @renderer.does_have_source_text
          return true
        end
      end
         
         
      def text_item_distinct_parent_should_have_end_links
        if @renderer.does_have_source_text == true
          return true
        elsif @renderer.does_have_source_text == false
          return text_item_distinct_parent_without_source_should_have_end_links
        end
      end
      
      
      def text_item_distinct_parent_without_source_should_have_end_links
        if determine_whether_subsections_are_distinct == true
          return false
        elsif determine_whether_subsections_are_distinct == false
          return true
        end
      end
        
      
    end
  end
end
