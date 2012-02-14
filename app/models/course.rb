# -*- encoding : utf-8 -*-
require 'chinese_pinyin'
class Course
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel

  belongs_to :institute
  belongs_to :user #who created this?
  
	has_many :coursewares,:dependent=>:destroy
	
	has_many :favorites,:dependent=>:destroy
	has_many :favorite_users,:source=>:user,:through=>:favorites
	
  has_many :teachings,:dependent=>:destroy
	has_many :teachers,:through=>:teachings

  validates_length_of :name,:within=>2..20
  validates_presence_of :name
  validate :not_too_much,:on=>:create,:unless=>'self.user and self.user.is_admin'
  validate :identified,:on=>:create,:unless=>'self.user and self.user.is_admin'
  def identified
    return unless self.user
    unless self.user.identified>0
      errors.add(:base,'只有通过了身份认证的用户可以建立课程页面')
    end
  end
	def not_too_much
		guanshui = true
		return unless self.user
		if self.user.courses.empty?
		  guanshui = false
		end
		self.user.courses.order('created_at DESC').limit(1).each do |r|
			if Time.now - r.created_at >= 3600*24
				guanshui = false
			end
		end
		if guanshui
			errors.add(:base,'您短时间内不能建立太多页面')
		end
	end	


	
  before_save :set_pinyin
  before_save :set_qcache

private
  def set_pinyin
    self.pinyin = Pinyin.t(self.name,'')
    return true
  end
  
  def set_qcache
  	tee=self.teachers.collect(&:name)
    if tee.empty?
      self.qcache1 = "#{self.name} [#{self.coursewares.count}资源]"
      self.qcache2 = Pinyin.t("#{self.name}",'')
    else
      self.qcache1 = "#{self.name} [#{tee.join(',')}, #{self.coursewares.count}资源]"
      self.qcache2 = Pinyin.t("#{self.name} [#{tee.join(',')}]",'')
    end
    return true
  end
  
end
