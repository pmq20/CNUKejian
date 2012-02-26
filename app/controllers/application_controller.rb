# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource)
  	goto = "/welcome/main\n"
  end
  
  def sleeping
    render text:'The developer is sleeping.' and return
  end
end
