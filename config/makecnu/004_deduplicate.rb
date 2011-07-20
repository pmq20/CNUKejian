# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'
require 'mechanize'

require File.expand_path("../../environment",__FILE__)

last = nil
def nil.name
  ''
end
Course.order('name').each do |c|
  if c.name.strip==last.name.strip
    c.destroy
    p "deleted"
  else
    #p c.name
    last = c
  end
end
