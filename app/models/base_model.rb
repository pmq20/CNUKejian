# coding: utf-8
module BaseModel
  extend ActiveSupport::Concern
  included do
  end

  module ClassMethods
  end
  
  # 检测敏感词
  def spam?(attr)
    value = eval("self.#{attr}")
    return false if value.blank?
    if value.class == [].class
      value = value.join(" ")
    end
    m = []
    NaughtyWord.all.each do |spam_reg|
      if matched = value.match(/#{spam_reg.word}/)
        m << "[#{matched.to_a.join(",")}]"
      end
    end
    if m.empty?
      return false
    else
      self.errors.add(attr,"带有敏感内容#{m.to_a.join(",")},请注意一下！")
    end
  end

end


