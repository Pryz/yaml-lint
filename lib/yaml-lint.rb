#!/usr/bin/env ruby

require 'yaml'

module Logging
  ESCAPES = { :green  => "\033[32m",
              :yellow => "\033[33m",
              :red    => "\033[31m",
              :reset  => "\033[0m" }

  def info(message)
    emit(:message => message, :color => :green)
  end

  def warn(message)
    emit(:message => message, :color => :yellow)
  end

  def error(message)
    emit(:message => message, :color => :red)
  end

  def emit(opts={})
    color   = opts[:color]
    message = opts[:message]
    print ESCAPES[color]
    print message
    print ESCAPES[:reset]
    print "\n"
  end
end

class YamlLint
  include Logging

  def initialize(file)
    @file = file
    @error = false
  end

  def do_lint
    unless File.exists? @file
      error "File #{@file} does not exist"
      @error = true
    else
      if File.directory? @file
        self.parse_directory @file
      else
        self.parse_file @file
      end
    end
    @error ? false : true
  end

  def parse_directory(directory)
    return nil if ['.', '..'].include? directory
    Dir.glob("#{directory}/*").each do |fdir|
      if File.directory? fdir
        self.parse_directory fdir
      else
        self.parse_file fdir
      end
    end
    nil
  end

  def parse_file(file)
    unless File.extname(file) =~ /.(yaml|yml)$/
      error "The extension of the file #{file} should be .yaml or .yml"
      @error = true
      return
    end
    begin
      YAML.load_file(file)
    rescue Exception => err
      error "File : #{file}, error: #{err}"
      @error = true
    else
      info "File : #{file}, Syntax OK"
    end
    nil
  end
end
