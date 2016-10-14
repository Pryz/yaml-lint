#!/usr/bin/env ruby

require 'yaml'

module Logging
  ESCAPES = { :green  => "\033[32m",
              :yellow => "\033[33m",
              :red    => "\033[31m",
              :reset  => "\033[0m" }

  def info(message)
    emit(:message => message, :color => :green, :out => STDOUT) unless @config[:quiet]
  end

  def warn(message)
    emit(:message => message, :color => :yellow, :out => STDOUT) unless @config[:veryquiet]
  end

  def error(message)
    emit(:message => message, :color => :red, :out => STDERR) unless @config[:veryquiet]
  end

  def emit(opts={})
    color   = opts[:color]
    message = opts[:message]
    opts[:out].puts ESCAPES[color] + message + ESCAPES[:reset]
  end
end

class YamlLint
  include Logging

  def initialize(file, config={})
    @file = file
    @config = config
    @config[:quiet] = true if @config[:veryquiet]
    @config[:nocheckfileext] ||= false
  end

  def do_lint
    unless File.exists? @file
      error "File #{@file} does not exist"
      return 0
    else
      if File.directory? @file
        return self.parse_directory @file
      else
        return self.parse_file @file
      end
    end
  end

  def parse_directory(directory)
    Dir.glob("#{directory}/*").inject(0) do |mem, fdir|
      if File.directory? fdir
        mem + parse_directory(fdir)
      else
        mem + parse_file(fdir)
      end
    end
  end

  def parse_file(file)
    if (not File.extname(file) =~ /.(yaml|yml)$/) && (not @config[:nocheckfileext])
      if @config[:ignorenoyaml]
        info "File : #{file}, Ignored"
        return 0
      end
      error "The extension of the file #{file} should be .yaml or .yml"
      return 1
    end
    begin
      YAML.load_file(file)
    rescue Exception => err
      error "File : #{file}, error: #{err}"
      return 1
    else
      info "File : #{file}, Syntax OK"
      return 0
    end
  end
end
