# -*- encoding : utf-8 -*-
class WelcomeController < ApplicationController
	def weird
		sth = params['Cache'].split('Cache')[0]
		sth ||= ''
		@target = '/'+sth
		render 'redirect_page'
	end
	
  def autocomplete_course_name
    render text:Course.where('hidden=0').where('qcache2 like ? or qcache1 like ?','%'+params[:term]+'%','%'+params[:term]+'%').order('teachings_count+coursewares_count DESC').limit(20).collect(&:qcache1).to_json
  end

  def index
  	if params[:main] and not params[:main].include?('Cache-Control')
	  	@main = params[:main] 
  	else
	  	@main = '/welcome/main'
  	end
    render :layout=>false
  end
#上
  def top
    render :layout=>false
  end
#下  
  def menu
	  render :layout=>false
  end
  
  def xi
  	render :layout=>false
  end
  
  def main
#  @movie=Course.find(11306) #百部经典电影
		@users = User.order('created_at DESC').limit(5)
		@lt = Courseware.where('hidden=0').order('quintessence DESC,purchases_count DESC').limit(5)
		@zhengzhi = []
		@zhengzhi << Course.find(18);#zhengzhi1.name = '思修' #思想道德修养与法律基础
		@zhengzhi << Course.find(43);#zhengzhi2.name = '近代史' #中国近现代史纲要
		zhengzhi3 = Course.find(11);
		zhengzhi3.name = '马克思主义基本原理概论' #马克思主义基本原理概论
		@zhengzhi << zhengzhi3
		zhengzhi4 = Course.find(606)
		zhengzhi4.name = '毛泽东思想和中国特色社会主义理论体系概论' #毛泽东思想和中国特色社会主义理论体系概论
		@zhengzhi << zhengzhi4
		@rt = Courseware.where('hidden=0').order('created_at DESC').limit(5)
  end

	def download_go_post
	  @course = Course.new
	end
	def download_go_post
	  course = Course.find_by_name(params[:q].split[0].strip)
	  if course
	    redirect_to course
	  else
	    redirect_to "/courses/new?q=#{params[:q]}"
	  end
	end
	
	def upload_go_post
	  course = Course.find_by_name(params[:q].split[0].strip)
	  if course
	    redirect_to "/coursewares/new?course_id=#{course.id}"
	  else
	    redirect_to "/courses/new?q=#{params[:q]}"
	  end
	end
	
	def upload_go
	end
	
	def res_rank
		@coursewares = Courseware.where('hidden=0').order('replies_count*2+purchases_count*5 DESC,created_at DESC').limit(100)
	end

	def replies_rank
		@replies = Reply.order('created_at DESC').limit(100)
	end	
	
	def selfdefined
		@courses = Course.where('hidden=0 and user_id is not NULL').order('created_at DESC')
	end
	
	def user_rank
		@left = User.all
		@left.each {|user| user.calculate_sellingsum}
		@left.sort!{|x,y| (-x.sellingsum)<=>(-y.sellingsum)}
		@right = User.order('credit DESC').limit(10)
		@bottom = User.order('corenum DESC,coursewares_count DESC').limit(10)
	end
	
	def statistics
	end
	
	def search
	end
	
	def show_yonghu
		@user = User.find(params[:id])
		flash[:alert]='无此用户' and redirect_to('/') and return unless @user
		if user_signed_in? and current_user.id == params[:id].to_i
		  redirect_to('/cpan/profile')
		end
	end

	def purchase_post
		return unless params[:courseware_id]
		courseware = Courseware.find(params[:courseware_id])
		return unless courseware
		if !current_user
			flash[:alert] = '请先登录或注册（注册链接在屏幕右上角）'
			session[:user_return_to]="/courses/#{courseware.course_id}" 
			render text:"window.location.href='/users/sign_in'" and return
		end
		if current_user.id==courseware.user_id
			render text:"#{area}.html('不能购买自己的课件')" and return
		end
		area = '$("#purpan_'+params[:courseware_id]+'")'
		if current_user.credit < courseware.price
			#若不允许透支，在这里截断执行流
		end
		purchase = Purchase.new(courseware_id:courseware.id,user_id:current_user.id,amount:courseware.price)
		if purchase.save
			useragain = User.find(purchase.user_id)
			if useragain.credit >=0
				msg = '<span style=\"color:green\">购买成功</span>'
			else
				msg = '<span style=\"color:purple\">购买成功,但积分已透支</span>'
			end
			render text:"unbought[#{courseware.id}]=false;#{area}.html('#{msg}');$('#user_#{courseware.user.id}_credit').html('#{courseware.user.credit_display}');$('#user_#{current_user.id}_credit').html('#{current_user.credit_display}');window.parent.frames[0].eval(\"$('#jifen').html('#{User.find(purchase.user_id).credit_display.gsub('"','\"')}')\")" and return
		else
			render text:"#{area}.html('您已经购买过一次')" and return
		end
	end
	
end
