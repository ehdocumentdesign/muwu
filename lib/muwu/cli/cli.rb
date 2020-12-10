module Muwu
  class Cli


    include Muwu


    def initialize(args)
      @args = args.map do |a|
        case a
        when nil
          nil
        else
          a.downcase.strip
        end
      end

      @current_working_directory = Dir.pwd
    end



    public


    def evaluate_arguments
      if @args == []
        puts CliHelp.new(:summary).message
      elsif @args != []
        case @args[0]
        when 'compile'
          evaluate_command_compile
        when 'concat'
          evaluate_command_concat
        when 'help'
          evaluate_command_help
        when 'inspect'
          evaluate_command_inspect
        when 'new'
          evaluate_command_new
        when 'publish'
          evaluate_command_publish
        when 'reset'
          evaluate_command_reset
        when 'sync'
          evaluate_command_sync
        when 'view'
          evaluate_command_view
        when '--version'
          puts VERSION
        else
          puts CliHelp.new(:summary).message
        end
      end
    end



    private


    def evaluate_command_compile
      if @args[1] == nil
        Controller.new(@current_working_directory).compile

      elsif @args[1] == 'css'
        Controller.new(@current_working_directory).compile_css

      elsif @args[1] == 'html'
        evaluate_command_compile_html

      elsif @args[1] == 'js'
        Controller.new(@current_working_directory).compile_js

      else
        puts CliHelp.new(:compile).message
      end
    end


    def evaluate_command_compile_html
      if @args[2] == nil
        Controller.new(@current_working_directory).compile_html

      elsif @args[2] =~ /\A[0-9]+\z/
        Controller.new(@current_working_directory).compile_html_by_index(@args[2].to_i)

      else
        puts CliHelp.new(:compile).message
      end
    end


    def evaluate_command_concat
      Controller.new(@current_working_directory).concat
    end



    def evaluate_command_help
      if @args[1] == nil
        puts CliHelp.new(:summary).message

      else
        case @args[1]
        when 'compile'
          puts CliHelp.new(:compile).message
        when 'concat'
          puts CliHelp.new(:concat).message
        when 'inspect'
          puts CliHelp.new(:inspect).message
        when 'new'
          puts CliHelp.new(:new).message
        when 'publish'
          puts CliHelp.new(:publish).message
        when 'reset'
          puts CliHelp.new(:reset).message
        when 'sync'
          puts CliHelp.new(:sync).message
        when 'view'
          puts CliHelp.new(:view).message
        else
          puts CliHelp.new(:summary).message
        end
      end
    end


    def evaluate_command_inspect
      Controller.new(@current_working_directory).inspect
    end


    def evaluate_command_new
      Controller.new(@current_working_directory).new_project
    end


    def evaluate_command_publish
      Controller.new(@current_working_directory).publish(@args[1..-1])
    end


    def evaluate_command_reset
      if @args[1] == nil
        puts CliHelp.new(:reset).message

      else
        case @args[1]
        when 'compiled'
          Controller.new(@current_working_directory).reset_compiled
        when 'css'
          Controller.new(@current_working_directory).reset_css
        else
          puts CliHelp.new(:reset).message
        end
      end
    end


    def evaluate_command_sync
      if @args[1] == nil
        puts CliHelp.new(:sync).message

      else
        case @args[1]
        when 'pull'
          Controller.new(@current_working_directory).sync_pull(@args[2..-1])
        when 'push'
          Controller.new(@current_working_directory).sync_push(@args[2..-1])
        else
          puts CliHelp.new(:sync).message
        end
      end
    end


    def evaluate_command_view
      Controller.new(@current_working_directory).view
    end


  end
end
