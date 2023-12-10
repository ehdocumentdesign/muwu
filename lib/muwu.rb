module Muwu


  VERSION = '3.1.0'

  GEM_HOME_LIB = File.absolute_path(File.join(File.dirname(__FILE__)))
  GEM_HOME_LIB_MUWU = File.absolute_path(File.join(GEM_HOME_LIB, 'muwu'))


  require 'commonmarker'
  require 'fileutils'
  require 'haml'
  require 'iso-639'
  require 'logger'
  require 'motion-markdown-it'
  require 'motion-markdown-it-plugins'
  require 'sassc'
  require 'yaml'


  require_relative 'loader'



  module_function


  def debug(file, line, info)
    Logger.new(STDERR).debug("#{file} #{line} #{info}")
  end


  def read(path)
    ProjectReader.build { |b| b.load_path(path) }
  end


end
