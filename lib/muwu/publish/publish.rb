module Muwu
  class Publish


    include Muwu


    def initialize(project, args: [])
      @path_local = project.path_compiled + File::SEPARATOR
      @path_remote = project.options.remote_publish
      @project = project
      @switches = args.push(project.options.rsync_options).flatten.sort.join(' ')
    end


    def up
      if @project.exceptions_include?(ProjectException::OptionRemotePublishValueNil)
        raise ProjectExceptionHandler::Fatal.new(ProjectException::OptionRemotePublishValueNil.new)
      else
        exec_rsync(source: @path_local, target: @path_remote)
      end
    end



    private


    def exec_rsync(source: nil, target: nil)
      if source && target
        puts "source: #{source.inspect}"
        puts "target: #{target.inspect}"
        puts "switches: #{@switches}"
        begin
          system "rsync #{@switches} #{source} #{target}", exception: true
        rescue Errno::ENOENT
          raise ProjectExceptionHandler::Fatal.new(ProjectException::RsyncNotAvailable.new)
        end
      end
    end


    def exec_rsync_demo(source: nil, target: nil)
      if source && target
        puts "** demo rsync"
        puts "source: #{source.inspect}"
        puts "target: #{target.inspect}"
        puts "switches: #{@switches}"
        puts "command: rsync #{@switches} #{source} #{target}"
      end
    end


  end
end
