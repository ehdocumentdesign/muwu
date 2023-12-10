module Muwu
  class Viewer


    include Muwu


    def initialize(project)
      document_home = project.manifest.find_document_html_by_index(0)
      if document_home
        document_home_filepath = File.join(project.path_compiled, document_home.filename)
        initialize_viewer(document_home_filepath)
      else
        puts "No documents in outline to view."
      end
    end


    def initialize_viewer(document_home_filepath)
      if File.exist?(document_home_filepath)
        begin
          system "lynx #{document_home_filepath}", exception: true
        rescue Errno::ENOENT
          raise ProjectExceptionHandler::Fatal.new(ProjectException::LynxNotAvailable.new)
        end
      else
        puts "Compiled document not found: #{document_home_filepath}"
      end
    end


  end
end
