#!/usr/bin/env ruby
# encoding: utf-8

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

require 'rubygems' unless defined? Gem # rubygems is only needed in 1.8
require 'alfred'
require 'emoji'

def generate_feedback(alfred, query)
  feedback = alfred.feedback
  queries  = query.split
  emojis    = Emoji.emojis

  Emoji.select!(emojis, queries)
  emojis.each { |emoji| feedback.add_item(Emoji.item_hash(emoji)) }

  puts feedback.to_alfred
end

Alfred.with_friendly_error do |alfred|
  alfred.with_rescue_feedback = true
  query = ARGV.join(' ').strip
  generate_feedback(alfred, query)
end