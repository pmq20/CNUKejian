# -*- encoding : utf-8 -*-
class Reply
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
	belongs_to :user
	belongs_to :courseware,:counter_cache=>true
	attr_accessible :body
	validates_presence_of :body
	validates_length_of :body,:within=>1..100
	validate :not_too_much
	def not_too_much
		guanshui = true
		if self.courseware.replies.empty?
		  guanshui = false
		end
		self.courseware.replies.order('created_at DESC').limit(3).each do |r|
			if r.user_id != self.user_id
				guanshui = false
			elsif Time.now - r.created_at >= 3600
				guanshui = false
			end
		end
		if guanshui
			errors.add(:base,'您似乎在灌水')
		end
	end	

	
	def self.human_attribute_name(attr, options = {})
    case attr
      when :body
	      '回复内容'
      else
  	    attr
    end
	end
	
end
