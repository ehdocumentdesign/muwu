module Muwu
  class RenderMarkupToHtml


    require 'cgi'
    require 'commonmarker'
    require 'haml'
    require 'motion-markdown-it'
    require 'motion-markdown-it-plugins'

    
   
    def initialize(project)
      @project = project
    end
    
    
    
    public
    
    
    def render(filename)
      case File.extname(filename).downcase
      when '.md'
        render_md(filename)
      when '.haml'
        render_haml(filename)
      end
    end
    
    
        
    private
    
    
    def read_haml_text(filename)
      File.read(filename)
    end
    
    
    def read_markdown_text(filename)
      if @project.options.markdown_allows_raw_html == true
        File.read(filename)
      else
        CGI.escapeHTML(File.read(filename))
      end
    end
    
    
    def render_haml(filename)
      text = read_haml_text(filename)
      Haml::Engine.new(text, {suppress_eval: true}).render
    end
    
    
    def render_md(filename)
      text = read_markdown_text(filename)
      case @project.options.markdown_renderer
      when 'commonmarker'
        render_md_commonmarker(text)
      when 'motion-markdown-it'
        render_md_motion_markdown_it(text)
      end
    end
    
    
    def render_md_commonmarker(text)
      if @project.options.render_punctuation_smart
        CommonMarker.render_doc(text, :SMART).to_html
      else
        CommonMarker.render_doc(text, :DEFAULT).to_html
      end
    end
    
    
    def render_md_motion_markdown_it(text)
      if @project.options.render_punctuation_smart
        MarkdownIt::Parser.new({html: true, typographer: true}).use(Muwu::Var::MotionMarkdownItPlugins::Deflistdiv).render(text)
      else
        MarkdownIt::Parser.new({html: true}).use(Muwu::Var::MotionMarkdownItPlugins::Deflistdiv).render(text)
      end
    end

      
    
  end
end