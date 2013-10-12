#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require 'alfred'
require 'emoji'

Alfred.with_friendly_error do |alfred|
  fb = alfred.feedback
  alfred.with_rescue_feedback = true

  query = ARGV.join(' ').strip
  emojis = Emoji.emojis

  Emoji.select!(emojis, query.split)
  emojis.each do |emoji|
    fb.add_item(Emoji.item_hash(emoji))
  end

  puts fb.to_xml
end