# -*- encoding : utf-8 -*-
require 'digest/md5'
require 'mechanize'
require 'iconv'

class String
  def make_clean!
    while "\n"==self[-1] or "\t"==self[-1] or "\r"==self[-1]
      self.slice!(-1)
    end
    while "\n"==self[0] or "\t"==self[0] or "\r"==self[0]
      self.slice!(0)
    end
    self
  end
  
  def no_parentheses!
    i=0
    while i<self.size
      if self[i]=='（'
        self.slice!(i)
        while i<self.size-1 and self[i]!='）'
          self.slice!(i)
        end
        self.slice!(i)
      end
      i+=1
    end
    self
  end
  
  def getout
    Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",self)
  end
  

end

class User < ActiveRecord::Base
	LEVELNAME = ['无业游民','职业侠客','大侠','骑士','圣骑士','精灵',
							            '精灵王','法师','大法师','天神','法老']
	LEVELRequirement = [ 0,      1 ,   10 ,  50 ,  150 ,  300,
	                           500 , 1000 ,2000  ,5000 ,10000]
	                           
  has_many :courses # courses created by the user
  
  has_many :coursewares,:dependent=>:restrict
  has_many :replies,:dependent=>:destroy
  
  has_many :favorites,:dependent=>:destroy
	has_many :favorite_courses,:source=>:course,:through=>:favorites
  
  has_many :purchases,:dependent=>:destroy
  has_many :bought_coursewares,:source=>:courseware,:through=>:purchases
  
  belongs_to :institute
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lastseenable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :xiaowai,:xb,:institute_id,:nickname,:avatar,:number, :email, :password, :password_confirmation, :remember_me
  validates_presence_of :number
  validates_uniqueness_of :number
  validates_format_of :number,:with=>/^\d+$/,:message=>'应由数字组成',:if=>'!self.xiaowai'
  validates_length_of :number,:is=>10,:message=>'应为一个10位数',:if=>'!self.xiaowai'
  validates_format_of :number,:with=>/^[a-zA-Z]/,:message=>'应以字母开头',:if=>'self.xiaowai'
  validates_length_of :number,:within=>3..12,:message=>'的长度应在3到12之间',:if=>'self.xiaowai'
	validates_length_of :avatar,:within=>1..50
	validates_length_of :nickname,:within=>0..20
  #validates_presence_of :password,:message=>'密码不能为空'
  #validates_length_of :password,:within=>6..50,:too_long=>'密码不可长于50个字符',:too_short=>'密码不可短于6个字符'
  #validates_format_of :email,:with=>/\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  #validates_uniqueness_of :email

  
  def self.human_attribute_name(attr, options = {})
    case attr
      when :number
	      '用户名'
      when :email
  	    '邮箱地址'
      when :password_confirmation
  	    '密码确认'
      when :password
  	    '密码'
      when :remember_me
  	    '记住我'
      else
  	    attr
    end
	end
	
	def sellings
		q = []
  	self.coursewares.each do |cw|
  		q << "courseware_id=#{cw.id}"
  	end
  	return nil if q.empty?
		Purchase.where(q.join(' or '))
	end

	attr_accessor :sellingsum
	def calculate_sellingsum
			self.sellingsum = 0 and return unless self.sellings
			self.sellingsum = self.sellings.select('count(id) as sum').first.sum
			self.sellingsum = 0 if !self.sellingsum
	end
	
	def ontology
	  return nickname if nickname and nickname!=''
		return number
	end

	def institue_name
	  if self.institute!=nil
	    self.institute.name
	  else
		  '未知'
		end
	end
	
	def identified_str
		if self.xiaowai
			return "非学生"
		end
		
	  if identified>0
      "<span style=\"color:green\">已通过</span>".html_safe
	  else
	    "<span style=\"color:red\">未通过</span> (将密码修改为<span style=\"color:blue\">选课系统密码</span>即可通过身份认证，通过后系统可立即自动读取您选修过的课程置入“我的课程”；系统不存储密码明文也不会修改您的选课系统内容，请放心使用)".html_safe
	  end
	end
	
	def level_name
		LEVELNAME[self.level]
	end
	
	def credit_display
		if self.credit>=0
		  sprintf("%.1f",self.credit)
		else
			"<span style=\"color:purple\">#{sprintf("%.1f",self.credit)}</span>".html_safe
		end
	end
	
	def credit_qingkuang
		if self.credit > 0
			"正常"
		elsif self.credit > -10
			"已透支"
		elsif self.credit > -50
			"严重透支"
		elsif self.credit > -100
			"濒临破产"
		else
			"引发经济危机"
		end
	end
	
	def online
		if self.last_seen and Time.now - self.last_seen < 600
			true
		else
			false
		end
	end
	
	
	def import_info(deep=false)
		begin
  		agent = Mechanize.new
  		agent.get("http://jzd.cnu.edu.cn:8033/loginAction.do?zjh=#{self.number}&mm=#{self.md5pass}")
      self.memo = '' if !self.memo
  		if nil==agent.page.forms[0]
  			self.memo += "Logged in.\n"
  			if 0==self.identified
  			  self.credit += 8
  			end
  			self.identified = 0 - self.identified if self.identified < 0
  			self.identified += 1
  			contributed = false
  			agent.get("http://202.204.208.75/lnkbcxAction.do")
  			f = agent.page.forms[0]
  			arr = Array.new(f.fields[0].options)
  			reg = /^([^a-zA-Z0-9（）\(\)ⅠⅡⅢⅣⅤⅥⅦⅧⅨⅩ]*)/
  			newness = 0
  			arr.each do |v|
  				newness += 1
  				f.fields[0].value = v
  				f.submit
  				agent.page.search('td.pageAlign')[1].children[1].children[1].children.each do |c| 
  					next if c.children.size != 34
  					coursenumber = Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",c.children[2].children[0].to_s).make_clean!
  					coursename = Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",c.children[4].children[0].to_s).make_clean!
  					coursecredit = Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",c.children[8].children[0].to_s).make_clean!
  					stringteachers = Iconv.conv("UTF-8//IGNORE","GB18030//IGNORE",c.children[14].children[0].to_s).make_clean!
  					teachers = stringteachers.split(' ')
  					next if coursename =~ /习题课/
  					ss = coursename.split(/[（）\(\)]/)
  					unless ss.size>1 and ss[1].size>1
  					  if coursename =~ reg
  					    coursename = String.new $1
  					  end
  					end
  					next unless coursename and coursename!=''
  					coursename = coursename[0..-2] if '-'==coursename[-1]
  					co = Course.find_by_name(coursename)
  					if co
  					  self.memo += "Found #{coursename}..."
  					else
  						co = Course.create!(name:coursename,number:coursenumber,credit:coursecredit)
  						contributed = true
  						co.memo = "Created by #{self.number}"
  						co.save
  					  self.memo += "Created Course(name:#{coursename},number:#{coursenumber},credit:#{coursecredit})..."
  					end
					
  					if 0==Favorite.where(course_id:co.id,user_id:self.id).count
  					  fav = Favorite.create!(course_id:co.id,user_id:self.id,newness:newness)
  					else
  					  fav = Favorite.where(course_id:co.id,user_id:self.id).first
  					end
					
  					self.memo += "("
  					teachers.each do |t|
  						t.strip!
  						t.chop! if '*'==t[-1]
  						t.no_parentheses!
  						self.memo += t + ','
  						next if !t or ''==t or 'null'==t
  						teacher = Teacher.find_or_create_by_name(t)
  						if 0==Teaching.where(course_id:co.id,teacher_id:teacher.id).count
  							Teaching.create!(course_id:co.id,teacher_id:teacher.id)
  							contributed = true
  							self.memo += ".done."
  						else
  						  self.memo += ".let_go."
  						end
  						if !fav.teacher_id
	  						fav.teacher_id = teacher.id 
	  						fav.save!
	  					end
  					end
  					self.memo += ")\n"
  				end
  				f = agent.page.forms[0]
  			end
  			if contributed
  			  self.memo += "Contributed!\n"
  			else
  			  self.memo += "Not Contributed :(\n"
  			end
  			#2: info
  			agent.get("http://202.204.208.75/xjInfoAction.do?oper=xjxx")
  			fortysix = agent.page.body.split('<td class="fieldName" width="180">')
  			def nil.split
  			  ''
  			end
        self.xm = fortysix[2].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!
        if !self.nickname or self.nickname==''
          self.nickname = self.xm
        end
        self.sfzh = fortysix[6].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.xb = fortysix[7].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.xslb = fortysix[8].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.mz = fortysix[12].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.jg = fortysix[13].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.csrq = fortysix[14].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.zzmm = fortysix[15].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.kq = fortysix[16].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.byzx = fortysix[17].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.gkzf = fortysix[18].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.rxrq = fortysix[25].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        ins = Institute.find_by_name(fortysix[26].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip)
        self.institute_id = ins.id if ins
        self.zy = fortysix[27].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.nj = fortysix[29].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.bj = fortysix[30].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.xq = fortysix[33].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        self.pyfs = fortysix[39].split("width=\"275\">")[1].split("</td>")[0].getout.make_clean!.strip
        #3: photo
  			agent.get("http://202.204.208.75/xjInfoAction.do?oper=img").save_as(DATA_DIR+"/users/#{self.number}.jpg")
        #Over.
        #Deep? Import more
        if deep
        	#TODO
        end
  		else
  		  self.identified = 0 - self.identified
  	    throw 'Login Failed.'
  	  end
		rescue => msg
		  self.memo += "#{msg}\n"
		end
		self.memo = self.memo[-30000..-1] if self.memo.size > 30000
		return self
	end

	def check_shengji
		self.corenum = self.coursewares.inject(0){|sum,cw| sum+cw.purchases.where('overdrawn=0').count}
		LEVELRequirement.size.times do |i|
			if i==LEVELRequirement.size-1
				self.level = LEVELNAME.size-1
				break
			elsif self.corenum >= LEVELRequirement[i] and self.corenum < LEVELRequirement[i+1]
				self.level = i
				break
			end
		end
    return self
	end

  before_save :zhuan_md5
private
	def zhuan_md5
		if !self.xiaowai and self.password and !self.password.empty?
			self.md5pass = Digest::MD5.hexdigest(self.password)
Thread.new{
self.import_info
}
		end
		return true
	end

end
