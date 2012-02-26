# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'
require 'mechanize'

require File.expand_path("../../environment",__FILE__)

ActiveRecord::Base.connection.execute('TRUNCATE TABLE `institutes`')


agent = Mechanize.new
agent.get('http://202.204.208.75/loginAction.do?zjh=1090500165&mm=b0731bc9ed97a5b3a9f6fc3517e63381')
agent.get('http://202.204.208.75/kclbAction.do')
list = agent.page.forms[0].fields[5]
list.node.children.each{|f| Institute.create!(name:f.children.first.to_s) if f.children.first}
