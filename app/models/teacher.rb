# -*- encoding : utf-8 -*-
require 'chinese_pinyin'
class Teacher < ActiveRecord::Base
	belongs_to :institution
  has_many :teachings
  has_many :courses,:through=>:teachings
  has_many :coursewares

  before_save :set_pinyin
private
  def set_pinyin
    self.pinyin = Pinyin.t(self.name,'')
    return true
  end
end
