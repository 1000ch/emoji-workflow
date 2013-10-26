#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require 'alfred'
require 'emoji'

Alfred.with_friendly_error do |alfred|

  alfred.with_rescue_feedback = true

  query = ARGV.join(' ').strip

  puts Emoji.new(query).to_alfred(alfred)
end