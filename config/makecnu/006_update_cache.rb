# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'

require File.expand_path("../../environment",__FILE__)
=begin
Course.all.each do |c|
 p c.name
 ActiveRecord::Base.connection.execute("UPDATE `courses` SET `teachings_count` = '#{c.teachings.count}' WHERE `id` = #{c.id}")
 ActiveRecord::Base.connection.execute("UPDATE `courses` SET `coursewares_count` = '#{c.coursewares.count}' WHERE `id` = #{c.id}")
 ActiveRecord::Base.connection.execute("UPDATE `courses` SET `favorites_count` = '#{c.favorites.count}' WHERE `id` = #{c.id}")
 c.save!
 p 'ok'
end
=end
Courseware.all.each do |cw|
 ActiveRecord::Base.connection.execute("UPDATE `coursewares` SET `purchases_count` = '#{cw.purchases.count}' WHERE `id` = #{cw.id}")
 ActiveRecord::Base.connection.execute("UPDATE `coursewares` SET `assets_count` = '#{cw.assets.count}' WHERE `id` = #{cw.id}")
 ActiveRecord::Base.connection.execute("UPDATE `coursewares` SET `replies_count` = '#{cw.replies.count}' WHERE `id` = #{cw.id}")
end
Teacher.all.each do |t|
 ActiveRecord::Base.connection.execute("UPDATE `teachers` SET `coursewares_count` = '#{t.coursewares.count}' WHERE `id` = #{t.id}")
 ActiveRecord::Base.connection.execute("UPDATE `teachers` SET `teachings_count` = '#{t.teachings.count}' WHERE `id` = #{t.id}")
end
User.all.each do |u|
 ActiveRecord::Base.connection.execute("UPDATE `users` SET `purchases_count` = '#{u.purchases.count}' WHERE `id` = #{u.id}")
 ActiveRecord::Base.connection.execute("UPDATE `users` SET `coursewares_count` = '#{u.coursewares.count}' WHERE `id` = #{u.id}")
 ActiveRecord::Base.connection.execute("UPDATE `users` SET `favorites_count` = '#{u.favorites.count}' WHERE `id` = #{u.id}")
end
