# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'
require 'mechanize'

require File.expand_path("../../environment",__FILE__)

ActiveRecord::Base.connection.execute("update courses set neirongjianjie=NULL where neirongjianjie='td';")
ActiveRecord::Base.connection.execute("update courses set book1=NULL where book1='td';")
ActiveRecord::Base.connection.execute("update courses set book2=NULL where book2='td';")
