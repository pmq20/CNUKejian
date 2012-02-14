# -*- encoding : utf-8 -*-
class Institute
  include Mongoid::Document
  include Mongoid::Timestamps
  include BaseModel
  has_many :courses
  has_many :teachers
  has_many :users
end
