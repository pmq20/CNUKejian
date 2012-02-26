# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'
require 'mechanize'

require File.expand_path("../../environment",__FILE__)

Course.where('book1 is not NULL').order('institute_id').each {|c| print "[ #{c.institute.name},#{c.name},#{c.ben_yan},#{c.book1},#{c.book2} ];\n"}
