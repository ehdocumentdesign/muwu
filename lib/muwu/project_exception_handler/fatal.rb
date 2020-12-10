module Muwu
  module ProjectExceptionHandler
    class Fatal < StandardError


      def initialize(exceptions)
        @exceptions = [exceptions].flatten
        render_exceptions
        exit
      end


      def render_exception(exception)
        $stderr.puts "- #{exception.class}"
        $stderr.puts "  #{exception.report}"
      end


      def render_exceptions
        render_header
        @exceptions.each do |exception|
          render_exception(exception)
        end
        render_lf
      end


      def render_header
        $stderr.puts "#{self.inspect}"
      end


      def render_lf
        $stderr.puts "\n"
      end


    end
  end
end
