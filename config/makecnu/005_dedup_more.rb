# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'
require 'mechanize'

require File.expand_path("../../environment",__FILE__)

last_word = ''
reg = /^([^a-zA-Z0-9（）\(\)ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ\W]*)/
Course.order('name').each do |c|
	next unless c.name =~ reg and $1!=''
	if $1==last_word
	  p "deleting: #{c.name}"
		c.destroy
	else
	  last_word = $1
	  c.name = last_word
	  c.save!
	  #p c.name
	end
end
