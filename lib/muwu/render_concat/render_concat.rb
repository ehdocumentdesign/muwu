module Muwu
  class RenderConcat


    def initialize(project)
      @output_path = project.path_compiled
      @output_filename = project.html_basename + '.md'
      @project = project
      @manifest = project.manifest
    end


    public


    def render
      destination = File.join(@output_path, @output_filename)
      puts "- Writing `#{@output_filename}`"
      File.open(destination, 'w') do |f|
        @manifest.text_blocks.each do |text|
          text.sections.each do |text_item|
            render_text_item(f, text_item)
          end
        end
      end
    end


    def render_text_item(f, text_item)
      render_text_item_head(f, text_item)
      render_text_item_source(f, text_item)
      render_text_item_sections(f, text_item)
    end


    def render_text_item_head(f, text_item)
      f.puts '# ' + text_item.numbering.join('.')
      if heading_origin_is_basename_or_outline(text_item)
        f.puts '# ' + text_item.heading
        f.puts "\n"
      end
    end


    def render_text_item_sections(f, text_item)
      if text_item.does_have_child_sections
        text_item.sections.each do |ti|
          render_text_item(f, ti)
        end
        render_text_item_spacer(f, text_item)
      end
    end


    def render_text_item_source(f, text_item)
      if text_item.source_file_does_exist
        f.puts text_item.source.strip
      end
      render_text_item_spacer(f, text_item)
    end


    def render_text_item_spacer(f, text_item)
      f.puts "\n\n\n\n"
    end



    private


    def heading_origin_is_basename_or_outline(text_item)
      [:basename, :outline].include?(text_item.heading_origin)
    end



  end
end
