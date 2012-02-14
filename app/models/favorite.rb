# -*- encoding : utf-8 -*-
class Favorite
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
  belongs_to :user,:counter_cache=>true
  belongs_to :course,:counter_cache=>true

  before_create :check_consistancy
private
  def check_consistancy
    return false unless Course.exists?(self.course_id) and User.exists?(self.user_id)
    if Favorite.where(course_id:self.course_id,user_id:self.user_id).count>0
      Favorite.destroy_all(course_id:self.course_id,user_id:self.user_id)
    end
    return true
  end
end
