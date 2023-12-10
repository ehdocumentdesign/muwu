module Muwu
  class Controller


    include Muwu


    def initialize(current_working_directory)
      @current_working_directory = File.absolute_path(current_working_directory)
      @project = nil
    end



    public


    def compile
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderHtml.new(@project).render_all
      end
    end


    def compile_css
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderHtml.new(@project).render_css_only
      end
    end


    def compile_html_by_index(index)
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderHtml.new(@project).render_html_by_index(index)
      end
    end


    def compile_html
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderHtml.new(@project).render_html_only
      end
    end


    def compile_js
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderHtml.new(@project).render_js_only
      end
    end


    def concat
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderConcat.new(@project).render
      end
    end


    def inspect
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        RenderInspector.new(@project).render_inspector
      end
    end


    def new_project
      metadata = ControllerInteraction.new.request_metadata
      @project = ProjectStarter.new(@current_working_directory, metadata).new_project
      ProjectWriter.new(@project).write
    end


    def publish(args)
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        Publish.new(@project, args: args).up
      end
    end


    def reset_compiled
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        if ControllerInteraction.new.confirm_reset_compiled(@project)
          ProjectResetCompiled.new(@project).reset_compiled
        end
      end
    end


    def reset_css
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      elsif ControllerInteraction.new.confirm_reset_css(@project)
        ProjectResetCss.new(@project).reset_css
      end
    end


    def sync_pull(args)
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        Sync.new(@project, args: args).pull
      end
    end


    def sync_push(args)
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        Sync.new(@project, args: args).push
      end
    end


    def view
      @project = read_project_from_current_working_directory
      if @project.does_not_have_crucial_files
        reply_folder_does_not_have_valid_project
      else
        Viewer.new(@project).view
      end
    end



    private


    def read_project_from_current_working_directory
      ProjectReader.build { |b| b.load_path(@current_working_directory) }
    end


    def reply_folder_does_not_have_valid_project
      puts @project.exceptions
      puts "Is this a Muwu project home folder?"
    end


  end
end
