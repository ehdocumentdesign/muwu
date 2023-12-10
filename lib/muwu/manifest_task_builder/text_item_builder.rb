module Muwu
  module ManifestTaskBuilders
    class TextItemBuilder


      include Muwu
      include Helper


      attr_accessor(
        :heading_data,
        :numbering,
        :outline_fragment,
        :parent_manifest_text,
        :project,
        :source_filename,
        :text_item
      )


      def self.build
        builder = new
        yield(builder)
        builder.text_item
      end


      def initialize
        @text_item = ManifestTask::TextItem.new
      end


      def build_from_outline_fragment_text(outline_fragment, numbering, parent_manifest_text)
        @numbering = numbering
        @outline_fragment = outline_fragment
        @parent_manifest_text = parent_manifest_text
        @project = parent_manifest_text.project
        phase_1_set_project
        phase_2_set_source_filename
        phase_3_set_heading
        phase_4_set_destination
        phase_4_set_naming
        phase_4_set_numbering
        phase_5_set_sections
        phase_6_validate_file_presence
      end


      def phase_1_set_project
        @text_item.project = @project
      end


      def phase_2_set_source_filename
        @source_filename = determine_source_filename
        @text_item.source_filename = @source_filename
      end


      def phase_3_set_heading
        @heading_data = determine_heading_data
        @text_item.heading = @heading_data[:heading]
        @text_item.heading_origin = @heading_data[:origin]
      end


      def phase_4_set_destination
        @text_item.destination = @parent_manifest_text.destination
      end


      def phase_4_set_naming
        if Hash === @outline_fragment
          @text_item.naming = [@parent_manifest_text.naming, SanitizerHelper.sanitize_text_item_path(outline_step)].flatten
        else
          @text_item.naming = [@parent_manifest_text.naming, @heading_data[:heading]].flatten
        end
      end


      def phase_4_set_numbering
        @text_item.numbering = @numbering
      end


      def phase_5_set_sections
        if Hash === @outline_fragment
          @text_item.sections = determine_sections
        end
      end


      def phase_6_validate_file_presence
        ProjectValidator.new(@project).validate_task_text_item(@text_item)
      end



      private


      def build_text_item(step, section_numbering)
        ManifestTaskBuilders::TextItemBuilder.build do |b|
          b.build_from_outline_fragment_text(step, section_numbering, @text_item)
        end
      end


      def determine_child_steps_from_outline
        [@outline_step.flatten[1]].flatten
      end


      def determine_sections
        sections = []
        child_steps = [@outline_fragment.flatten[1]].flatten
        if child_steps.empty? == false
          child_section_numbering = section_number_extend(@text_item.numbering)
          child_steps.each do |step|
            child_section_numbering = section_number_increment(child_section_numbering)
            sections << build_text_item(step, child_section_numbering)
          end
        end
        sections
      end


      def determine_source_filename
        if @project.outline_text_pathnames_are_explicit
          determine_source_filename_explicitly
        elsif @project.outline_text_pathnames_are_flexible
          determine_source_filename_flexibly
        elsif @project.outline_text_pathnames_are_implicit
          determine_source_filename_implicitly
        else
          determine_source_filename_explicitly
        end
      end


      def determine_source_filename_explicitly
        filename = SanitizerHelper.sanitize_text_item_basename(outline_step)
        filepath = ['text']
        File.join([filepath, filename].flatten)
      end


      def determine_source_filename_flexibly
        if OutlineHelper.new(outline_step).text_step_flexible_suggests_file
          determine_source_filename_explicitly
        else
          determine_source_filename_implicitly
        end
      end

      # TODO: This method looks obsolete. Find its references.
      def determine_source_filename_implicitly
        # filename = make_filename_implicitly(outline_step)
        # filepath = make_filepath_implicitly
        # File.join([filepath, filename].flatten)
        determine_source_filename_cascade_implicitly
      end


      def determine_source_filename_cascade_implicitly
        source_filename = ''
        file_path = make_filepath_implicitly
        file_basename = SanitizerHelper.sanitize_text_item_path(outline_step)
        file_name_md = file_basename + '.md'
        file_name_haml = file_basename + '.haml'
        file_attempt_md = File.join([file_path, file_name_md].flatten)
        file_attempt_haml = File.join([file_path, file_name_haml].flatten)
        if File.exist?(file_attempt_md)
          source_filename = file_attempt_md
        elsif File.exist?(file_attempt_haml)
          source_filename = file_attempt_haml
        else
          source_filename = file_attempt_md
        end
        source_filename
      end


      def determine_heading_data
        if @text_item.source_file_does_exist
          determine_heading_from_file
        elsif @text_item.source_file_does_not_exist
          determine_heading_from_file_basename_or_outline
        end
      end


      def determine_heading_from_file
        case File.extname(@text_item.source_filename_absolute).downcase
        when '.haml'
          determine_heading_from_file_haml
        when '.md'
          determine_heading_from_file_md
        else
          determine_heading_from_file_basename
        end
      end


      def determine_heading_from_file_basename
        heading = File.basename(@text_item.source_filename, '.*')
        origin = :basename
        { heading: heading, origin: origin }
      end


      def determine_heading_from_file_basename_or_outline
        case @project.outline_text_pathnames
        when 'explicit'
          heading = File.basename(@text_item.source_filename, '.*')
          origin = :basename
        when 'flexible', 'implicit'
          heading = outline_step
          origin = :outline
        else
          heading = ''
          origin = nil
        end
        { heading: heading, origin: origin }
      end


      def determine_heading_from_file_haml
        first_line = File.open(@text_item.source_filename_absolute, 'r') { |f| f.gets("\n").to_s }
        if first_line =~ RegexpLib.haml_heading
          determine_heading_from_file_haml_first_line(first_line)
        else
          determine_heading_from_file_basename_or_outline
        end
      end


      def determine_heading_from_file_haml_first_line(first_line)
        heading = first_line.gsub(RegexpLib.haml_heading_plus_whitespace,'').strip
        origin = :text_source
        { heading: heading, origin: origin }
      end


      def determine_heading_from_file_md
        first_line = File.open(@text_item.source_filename_absolute, 'r') { |f| f.gets("\n").to_s }
        if first_line =~ RegexpLib.markdown_heading
          determine_heading_from_file_md_first_line(first_line)
        else
          determine_heading_from_file_basename_or_outline
        end
      end


      def determine_heading_from_file_md_first_line(first_line)
        heading = first_line.gsub(RegexpLib.markdown_heading_plus_whitespace,'').strip
        origin = :text_source
        { heading: heading, origin: origin }
      end


      def make_filepath_implicitly
        path_from_project_home = ['text']
        if @project.text_block_naming_is_simple
          path_from_project_home.concat(@parent_manifest_text.naming_downcase_without_text_root)
        elsif @project.text_block_naming_is_not_simple
          path_from_project_home.concat(@parent_manifest_text.naming_downcase)
        end
        safe_path_from_project_home = SanitizerHelper.sanitize_text_item_path(path_from_project_home)
        safe_path_from_project_home
      end



      def outline_step
        case @outline_fragment
        when Hash
          @outline_fragment.flatten[0].to_s
        else
          @outline_fragment.to_s
        end
      end


      def outline_step_sanitized
        SanitizerHelper.sanitize_text_item_path(outline_step)
      end


      def section_number_extend(number_incoming)
        number_outgoing = number_incoming.clone
        number_outgoing << 0
        number_outgoing
      end


      def section_number_increment(number_incoming)
        number_outgoing = number_incoming.clone
        number_outgoing[-1] = number_outgoing[-1].next
        number_outgoing
      end



    end
  end
end
