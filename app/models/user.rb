# -*- encoding : utf-8 -*-
require 'digest/md5'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
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
  Include default devise modules. Others available are:
  :token_authenticatable, :confirmable, :lockable and :timeoutable
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
	
	def online
		if self.last_seen and Time.now - self.last_seen < 600
			true
		else
			false
		end
	end
	
end
