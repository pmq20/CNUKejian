# -*- encoding : utf-8 -*-
class Institute < ActiveRecord::Base
  has_many :courses
  has_many :teachers
  has_many :users
end
