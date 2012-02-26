# -*- encoding : utf-8 -*-
#!/usr/local/bin/ruby
require 'rubygems'
require 'mechanize'

require File.expand_path("../../environment",__FILE__)

ActiveRecord::Base.connection.execute('TRUNCATE TABLE `courses`')


  def nil.split(arg)
    ''
  end
  
  def nil.strip
    ''
  end

agent = Mechanize.new
specialAgent = Mechanize.new 

last=nil
ins=nil
did_something = true
pagenum = 0
while(did_something)
	did_something = false
	pagenum += 1
	agent.get('http://202.204.208.75/loginAction.do?zjh=1090500165&mm=b0731bc9ed97a5b3a9f6fc3517e63381')
	specialAgent.get('http://202.204.208.75/loginAction.do?zjh=1090500165&mm=b0731bc9ed97a5b3a9f6fc3517e63381')
	agent.get('http://202.204.208.75/kclbAction.do?oper=kclb')
	agent.get('http://202.204.208.75/kclbAction.do?totalrows=617&page='+pagenum.to_s+'&pageSize=100')
	agent.page.search('tr').each{|f| next unless f.inspect=~/课程信息查看/;
	next unless f.children[2];
	f.children[2].to_s=~/\r\n\t\t\t\t\t\t\t\t\t\t\t(.*)\r\n\t\t\t\t\t\t\t\t\t\t/;
	number = $1

	f.children[6].to_s=~/\r\n\t\t\t\t\t\t\t\t\t\t\t(.*)\r\n\t\t\t\t\t\t\t\t\t\t/;
	next unless $1
	next if ''==$1.strip
	if last!=$1
		ins=Institute.find_by_name($1)
		unless ins
		  ins = Institute.create!(name:$1)
		  print "Institute.create!(name:#{$1})\n"
		end
		last=$1
	end
	f.children[8].to_s=~/\r\n\t\t\t\t\t\t\t\t\t\t\t(.*)\r\n\t\t\t\t\t\t\t\t\t\t/;
	ben_yan = $1
	f.children[4].to_s=~/\r\n\t\t\t\t\t\t\t\t\t\t\t(.*)\r\n\t\t\t\t\t\t\t\t\t\t/;
	name = $1
	specialAgent.get("http://202.204.208.75/kcxxAction.do?oper=kcxx_if&kch=#{number}")
	bulk = specialAgent.page.search('tr').first.inspect
	bulks = bulk.split(/课程号|课程名|英文课程名|开课院系|开课学期|本研标志|学分|学时|开始日期|结束日期|学科门类|实践周数|课内周学时|设计总学时|课程类别|课程级别|其中上机总学时|试验总学时|课程状态|课外学分|设计作业总学时|课外总学时|收费类别|教学方式|讨论辅导总学时|授课总学时|校区|考试类型|人数系数代码|课时费类别代码|标准人数|教师|师资队伍|教材|参考书|课程说明|内容 简介|英文内容简介|备注|教学大纲|英文教学大纲|主要修课对象/)
	Course.create!(number:number,name:name,ben_yan:ben_yan,	institute_id:ins.id,
	eng_name:bulks[3].split(',')[4].split('children=')[1].split('"')[1],
	credit:bulks[7].split('children=')[1].split(',')[0].split('"')[1].strip,
	credit_hours:bulks[8].split('children=')[1].split(',')[0].split('"')[1].strip,
	jiaoxuefs:bulks[24].split('children=')[1].split(',')[0].split('"')[1].strip,
	neirongjianjie:bulks[37].split('children=')[1].split(',')[0].split('"')[1],
	book1:bulks[34].split('children=')[1].split(',')[0].split('"')[1].strip,
	book2:bulks[35].split('children=')[1].split(',')[0].split('"')[1].strip)
	print "Course.create!(number:#{number},name:#{name},ben_yan:#{ben_yan},	institute_id:#{	ins.id})\n"
	did_something=true
	}
end
