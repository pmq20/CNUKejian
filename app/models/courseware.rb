# -*- encoding : utf-8 -*-
class Courseware
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
	KLASSES={1=>'讲义',2=>'作业',3=>'复习资料',4=>'往年试卷',5=>'课堂录像',-1=>'其他'}
  Max_Attachments = 100
  Max_Attachment_Size = 1000.megabyte
  has_many :replies,:dependent=>:destroy
  
  belongs_to :course,:counter_cache=>true
  belongs_to :user,:counter_cache=>true
  belongs_to :teacher,:counter_cache=>true

  has_many :purchases,:dependent=>:destroy
  has_many :buyers,:source=>:user,:through=>:purchases
  
  validates_presence_of :title
  validates_length_of :title,:within=>2..100
  validates_length_of :description,:maximum=>200
	validates_presence_of :other_teacher_name,:if=>'-1==self.teacher_id',:message=>'不能为空，您也可以从教师列表里选择一个教师'
	validates_length_of :other_teacher_name,:within=>2..10,:if=>'-1==self.teacher_id'
	validates_presence_of :semester
	validate :dont_give_me_a_messed_semester
	validates_presence_of :klass
	validates_inclusion_of :klass,:in=>KLASSES.keys.collect(&:to_s)
	validates_inclusion_of :quintessence,:in=>[1,2,3,4,5,0,"0","1","2","3","4","5"]
  validates_presence_of :price
  validate :dont_be_too_expensive
  validate :dont_not_give_assets
  def dont_be_too_expensive
  	unless self.price >= 0 and self.price <= 3.0
			errors.add(:base,"价格需定在0元至3元之间")
		end
 	end
 	def dont_not_give_assets
 		unless self.assets.size > 0
 			errors.add(:base,"请至少上传一个文件")
 		end
 	end
 	def dont_give_me_a_messed_semester
 		unless Courseware.possible_semesters.include?(self.semester)
 			errors.add(:base,"课件学期格式不正确")
 		end
 	end
  #----------[ assets ]-----------------
  has_many :assets,:dependent=>:destroy
  accepts_nested_attributes_for :assets,:allow_destroy=>true

  validate :validate_attachments,:if=>'!self.user.is_admin'
  validate :validate_guanshui,:if=>'!self.user.is_admin'
  def validate_attachments
    errors.add(:base,"太多文件啦 - 一个课件最多包含#{Max_Attachments}个文件") if assets.compact.length > Max_Attachments
    assets.each {|a| errors.add(:base,"文件太大 - #{a.name}的大小不能超过#{Max_Attachment_Size/1.megabyte}MB") if a.data_file_size > Max_Attachment_Size}
  end
  def validate_guanshui
		#计算这个用户上一个小时内的上传字节数和文件数
		zhi = 0
		number = 0
		self.user.coursewares.where('updated_at > ? or created_at > ?',(Time.now - 1.hours).utc,(Time.now - 1.hours).utc).each do |cw|
			num = cw.assets.where('created_at > ?',(Time.now - 12.hours).utc).collect(&:data_file_size).reduce(:+)
			zhi += num if num
			number += cw.assets.where('created_at > ?',(Time.now - 12.hours).utc).count
		end
		#Max_One_Day_Size here ----
		if zhi > 2.gigabyte and number > 8
			errors.add(:base,'您已上传大量大文件，为缓解服务器压力，请过一段时间再上传')
		end
		#Max_One_Day_Size here ----
  end
  #--------------------------------------


	attr_accessor :other_teacher_name
	attr_accessible :teacher_id,:course_id,:semester,:klass,:title,:price,:description,:other_teacher_name,:assets_attributes
	
	def klass_name
		KLASSES[self.klass.to_i]
	end
	
  def self.human_attribute_name(attr, options = {})
    case attr
      when :price
	      '价格'
      when :semester
  	    '课件学期'
      when :title
  	    '课件标题'
      when :klass
  	    '课件类别'
      when :description
  	    '课件描述'
  	  when :other_teacher_name
  	    '其他教师姓名'
      else
  	    attr
    end
	end

	def self.possible_semesters
		ret = []
		today = Time.now
		mowei = Time.new(2007,9,1)
		while today >= mowei
			if today.month >= 9 or today.month <= 1
				ret << "#{today.year}年秋学期（#{today.year}年9月～次年1月）"
			else
				ret << "#{today.year}年春学期（#{today.year}年3月～7月）"
			end
			today -= (365 / 2) * 24 * 3600
		end
		ret+['未知或更往前']
	end
	

	before_save :check_existence
	before_create :yanzheng
  after_create :inform_course_qcache
  after_create :add_to_users
  after_destroy :inform_course_qcache
  after_destroy :minus_from_users
private
 	def check_existence
 		if -1==self.teacher_id
 			return false unless self.other_teacher_name
 			t = Teacher.find_or_create_by_name(self.other_teacher_name)
 			Teaching.create(teacher_id:t.id,course_id:self.course_id)
 			self.teacher_id = t.id
 		else
 			return false unless Teacher.exists?(self.teacher_id)
 		end
 	  return false unless Course.exists?(self.course_id)
 	  return false unless User.exists?(self.user_id)
 	  return true
 	end

	def yanzheng
	  unless self.user.identified>0
	    self.hidden = true
	  end
	  if self.course.hidden
	    self.hidden = true
	  end
	end

  def inform_course_qcache
    return self.course.save
  end
  
  def add_to_users
    u = User.find(self.user_id)
    u.credit += 4
    u.save
    return true
  end
  
  def minus_from_users
    u = User.find(self.user_id)
    u.credit -= 4
    u.save
    return true
  end
end
