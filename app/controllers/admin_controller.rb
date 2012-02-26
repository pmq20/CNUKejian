# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  before_filter :authenticate_user!
  before_filter :must_be_admin
  def photo
    user = User.find(params[:id])
    render text:'user not found' and return unless user
    path = DATA_DIR+"/users/#{user.number}.jpg"
    if File.exists?(path)
  		send_file path, :type => 'image/jpeg',:disposition=>'inline'
  	else
  	  send_file DATA_DIR+'/users/no.jpg', :type => 'image/jpeg',:disposition=>'inline'
    end
  end
  
  def toggle_courseware_post
    cw = Courseware.find(params[:id])
    render text:'not found' and return if !cw
    if cw.hidden
      cw.hidden=false
    else
      cw.hidden=true
    end
    cw.save
    redirect_to "/coursewares"
  end
  def toggle_course_post
    c = Course.find(params[:id])
    render text:'not found' and return if !c
    if c.hidden
      c.hidden=false
    else
      c.hidden=true
    end
    if c.save
      redirect_to "/courses"
    else
      render text:c.errors.inspect
    end
  end
  
  def yonghus
  	@users = User.order('created_at DESC')
  end

  def replies
  	@replies = Reply.order('created_at DESC')
  end
  def replies_delete
		@reply = Reply.find(params[:id])
    render text:'无此reply' and return unless @reply
    @reply.destroy
		redirect_to "/admin/replies"
  end
private
  def must_be_admin
    render text:'admin only' and return unless current_user.is_admin
  end
  
end
