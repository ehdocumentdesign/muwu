module Muwu
  class Viewer


    include Muwu


    def initialize(project)
      document_home = project.manifest.find_document_html_by_index(0).filename
      document_home_path = File.join(project.path_compiled, document_home)
      if File.exists?(document_home_path)
        begin
          system "lynx #{document_home_path}", exception: true
        rescue Errno::ENOENT
          raise ProjectExceptionHandler::Fatal.new(ProjectException::LynxNotAvailable.new)
        end
      else
        puts "Compiled document not found: #{document_home_path}"
      end
    end



  end
end
