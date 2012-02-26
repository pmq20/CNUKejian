# -*- encoding : utf-8 -*-
class Teaching < ActiveRecord::Base
  belongs_to :teacher,:counter_cache=>true
  belongs_to :course,:counter_cache=>true

  before_create :check_consistancy
  after_create :inform_course_qcache
  after_destroy :inform_course_qcache
private
  def inform_course_qcache
    return self.course.save
  end
  
  def check_consistancy
    return false unless Course.exists?(self.course_id) and Teacher.exists?(self.teacher_id)
    if Teaching.where(course_id:self.course_id,teacher_id:self.teacher_id).count>0
      Teaching.destroy_all(course_id:self.course_id,teacher_id:self.teacher_id)
    end
    return true
  end

end
