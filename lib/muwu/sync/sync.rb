module Muwu
  class Sync


    include Muwu


    def initialize(project, args: [])
      @path_local = project.working_directory + File::SEPARATOR
      @path_remote = project.options.remote_sync
      @project = project
      @switches = args.push(project.options.rsync_options).flatten.sort.join(' ')
    end


    public


    def pull
      if @project.exceptions_include?(ProjectException::OptionRemoteSyncValueNil)
        raise ProjectExceptionHandler::Fatal.new(ProjectException::OptionRemoteSyncValueNil.new)
      else
        sync(source: @path_remote, target: @path_local)
      end
    end


    def push
      if @project.exceptions_include?(ProjectException::OptionRemoteSyncValueNil)
        raise ProjectExceptionHandler::Fatal.new(ProjectException::OptionRemoteSyncValueNil.new)
      else
        sync(source: @path_local, target: @path_remote)
      end
    end


    def sync(source: nil, target: nil)
      if source && target
        exec_rsync(source: source, target: target)
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
