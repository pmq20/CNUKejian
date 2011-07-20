# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
#  before_filter :sleeping
#  before_filter :not_for_teachers
  
  def after_sign_in_path_for(resource)
  	goto = "/welcome/main\n"
  end
  
  def sleeping
    render text:'The developer is sleeping.' and return
  end
  
  def not_for_teachers
	  ips = request.remote_ip.split('.')
  	if '202.204.213'==ips[0..2].join('.')# and ips[3].to_i>=129
	  	redirect_to('http://192.168.145.253:100') and return
	  end
  end
end
