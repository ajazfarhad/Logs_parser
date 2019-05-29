require_relative 'lib/parser'
require 'colorize'

logs = Parser.new ARGV[0]
logs.assemble_logs

puts "Most Page Views".blue
logs.most_page_views

puts "Unique Page Views".green
logs.unique_page_views

