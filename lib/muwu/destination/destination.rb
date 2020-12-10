module Muwu
  class Destination


    include Muwu


    attr_accessor(
      :margin_current,
      :output_class,
      :output_filename,
      :output_working_directory
    )
    attr_writer(
      :output
    )


    MARGIN = '  '


    def initialize
      @margin_depth = 0
      @output = nil
    end


    def inspect
      ["#{self.to_s}", "{", inspect_instance_variables, "}"].join(' ')
    end


    def inspect_instance_variables
      self.instance_variables.map { |v| "#{v}=#{instance_variable_get(v).inspect}" }.join(", ")
    end



    public


    def filename
      @output_filename
    end


    def margin_dec
      @margin_depth = @margin_depth.to_i - 1
    end


    def margin_inc
      @margin_depth = @margin_depth.to_i + 1
    end


    def margin_indent
      margin_inc
      yield
      margin_dec
    end


    def margin_to_zero
      @margin_depth = 0
    end


    def output
      begin
        if output_is_closed
          raise ProjectExceptionHandler::Fatal.new(ProjectException::OutputNotOpen.new)
        elsif output_is_opened
          @output
        end
      end
    end


    def output_is_closed
      @output == nil
    end


    def output_is_opened
      @output != nil
    end


    def output_stream
      announce_open
      output_open
      yield
      output_close
    end


    def padding_vertical(n)
      output.print ("\n" * n)
      yield
      output.print ("\n" * n)
    end


    def write_inline(value)
      write_value(value)
    end


    def write_inline_end(value)
      write_value(value)
      write_lf
    end


    def write_inline_indented(value)
      write_margin
      write_value(value)
    end


    def write_lf
      output.print "\n"
    end


    def write_line(value)
      write_margin
      write_value(value)
      write_lf
    end


    def write_margin
      output.print render_current_margin
    end


    def write_value(value)
      output.print value
    end



    private


    def announce_open
      if @output_class == 'file'
        puts "- Writing `#{output_filename}`."
      end
    end


    def destination_file_open
      filename = File.join(@output_working_directory, @output_filename)
      File.new(filename, 'w')
    end


    def destination_stdout
      $stdout
    end


    def output_close
      begin
        if output_is_closed
          raise ProjectExceptionHandler::Fatal.new(ProjectException::OutputNotOpen.new)
        elsif output_is_opened
          output_close_assignment
        end
      end
      margin_to_zero
    end


    def output_close_assignment
      if File === @output
        @output.close
        @output = nil
      else
        @output = nil
      end
    end


    def output_open
      margin_to_zero
      begin
        if output_is_opened
          raise ProjectExceptionHandler::Fatal.new(ProjectException::OutputAlreadyOpen.new)
        elsif output_is_closed
          output_open_assignment
        end
      end
    end


    def output_open_assignment
      case @output_class
      when 'file'
        @output = destination_file_open
      when 'stdout'
        @output = destination_stdout
      end
    end


    def render_current_margin
      (MARGIN * @margin_depth.to_i)
    end


  end
end
