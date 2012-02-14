# -*- encoding : utf-8 -*-
class Purchase
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
  belongs_to :user,:counter_cache=>true
  belongs_to :courseware,:counter_cache=>true

  before_create :check_consistancy_and_transfer
  after_create :somebody_check_shengji
  after_destroy :somebody_check_shengji
private
  def check_consistancy_and_transfer
    return false unless Courseware.exists?(self.courseware_id) and User.exists?(self.user_id)
    if Purchase.where(courseware_id:self.courseware_id,user_id:self.user_id).count>0
      return false
    end
    userFrom = User.find(self.user_id)
    userTo = User.find(self.courseware.user_id)
    userFrom.credit -= self.amount
    userTo.credit += self.amount*0.8
    self.overdrawn = true if userFrom.credit<0
    userFrom.save!
    userTo.save!
    return true
  end
  
  def somebody_check_shengji
  	self.courseware.user.check_shengji.save
  	return true
  end
  
end
