# -*- encoding : utf-8 -*-
class CpanController < ApplicationController
  before_filter :authenticate_user!
  def profile
  end
  def profile_put
  	@resource = current_user
    if params[:user][:password].empty?
      params[:user].delete :password 
      params[:user].delete :password_confirmation
    end

    if current_user.update_attributes(params[:user])
			flash[:notice] = '用户信息成功更新'    
    end
    render :action=>'profile'
  end

  def history
  	@huoli = 0
  	current_user.coursewares.each do |cw|
  		@huoli += cw.purchases.select('sum(amount) as sum').first.sum if cw.purchases.count>0
  	end
  	@huoli *= 0.8
	@sellings = current_user.sellings.order('created_at DESC') if current_user.sellings
  	@purchases = current_user.purchases.order('created_at DESC') if current_user.purchases
  end
  
  def pages
  	@courses = current_user.courses.order('created_at DESC')
  end

  def my_res
  	@coursewares = current_user.coursewares.order('created_at DESC')
  end
  
  def get_free_credit
  	
  end

	def change_avatar
	  @files = Dir.glob("#{RAILS_ROOT}/public/images/avatars/*.gif")
	  @files.sort!
	end
	def change_avatar_post
	  if current_user.update_attributes!(avatar:params[:avatar])
	    flash[:notice]='成功修改头像！'
	  else
	    flash[:alert]='头像修改失败！'
	  end
	  redirect_to '/cpan/profile'
	end
end
