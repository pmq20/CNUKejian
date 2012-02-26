# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require File.expand_path("../../environment",__FILE__)


Asset.all.each do |as|
	print as.data_file_name
	print " "
	print as.data.path
	if File.exists?(as.data.path)
		print "...OK\n"
	else
		throw as.data.path
	end
end
