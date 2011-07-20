# -*- encoding : utf-8 -*-
class Asset < ActiveRecord::Base
	has_attached_file :data,
										:url => "/assets/:id",
										:path => DATA_DIR+"/:id_partition"
	belongs_to :courseware,:counter_cache=>true
	
  def url(*args)
    data.url(*args)
  end
  
  def name
    data_file_name
  end
  
  def content_type
    data_content_type
  end
  
  def file_size
    data_file_size
  end
  
  def data_file_size_human
  	kb = data_file_size / 1024
  	if kb < 1024
	  	"#{kb} KB"
	  else
	  	"#{kb / 1024} MB"
	  end
  end
  
  def self.filename2icon(str)
    parts = str.downcase.split('.')
    if File.exists?("#{Rails.root}/public/images/icon/#{parts[-1]}.gif")
      "#{parts[-1]}.gif"
    else
      "unknown.gif"
    end
  end
end
