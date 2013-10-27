#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require "bundle/bundler/setup"
require 'alfred'
require 'emoji'

Alfred.with_friendly_error do |alfred|

  alfred.with_rescue_feedback = true

  # get arguments
  query = ARGV.join(' ').strip
  
  # get emojis with query
  Emoji.new(query).get_items.each do |item|
    alfred.feedback.add_item(item)
  end
  
  # put results
  puts alfred.feedback.to_alfred

end