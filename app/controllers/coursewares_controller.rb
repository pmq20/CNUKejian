# -*- encoding : utf-8 -*-
class CoursewaresController < ApplicationController
  before_filter :authenticate_user!
  

  # GET /coursewares/1
  # GET /coursewares/1.xml
  def show
    @courseware = Courseware.find(params[:id])
    @course = @courseware.course
    @reply = @courseware.replies.build
		render :layout=>'courses'
  end

  def create_reply
  	@reply = Reply.new(params[:reply])
  	@courseware = Courseware.find(params[:courseware_id])
  	render text:'Courseware not found' and return unless @courseware
  	@reply.courseware_id = params[:courseware_id]
  	@reply.user_id = current_user.id
  	if @reply.save
			redirect_to "/coursewares/#{@courseware.id}#comment-#{@reply.id}"
  	else
  	  @course = @courseware.course
	  	render :action=>'show',:layout=>'courses'
  	end
  end
  # GET /coursewares/new
  # GET /coursewares/new.xml
  def new
    @courseware = Courseware.new
    @courseware.price = 1.0
    @courseware.user_id = current_user.id
    render text:'course_id is required' and return unless params[:course_id]
    @courseware.course_id=params[:course_id]
    ttt = current_user.favorites.where('course_id=?',@courseware.course_id)
    if params[:teacher_id]
	    @courseware.teacher_id=params[:teacher_id]
	  elsif	ttt.count>0 and ttt.first.teacher_id
	  	@courseware.teacher_id = ttt.first.teacher_id
	  elsif @courseware.course.teachers.count>0
	  	@courseware.teacher_id = @courseware.course.teachers.first.id
	  else
			@courseware.teacher_id=-1
		end

		build_form_elements
		30.times {@courseware.assets.build}
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @courseware }
    end
  end

  # GET /coursewares/1/edit
  def edit
    @courseware = Courseware.find(params[:id])
    render text:'无此课件' and return unless @courseware
    if !current_user.is_admin
	  	render text:'只能编辑自己的课件' and return unless current_user.id==@courseware.user_id
	  end
		build_form_elements
		30.times {@courseware.assets.build}
  end

  # POST /coursewares
  # POST /coursewares.xml
  def create
    @courseware = Courseware.new(params[:courseware])
    @courseware.user_id = current_user.id

		build_form_elements
		
    respond_to do |format|
      if @courseware.save
        format.html { redirect_to(@courseware, :notice => 'Courseware was successfully created.') }
        format.xml  { render :xml => @courseware, :status => :created, :location => @courseware }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @courseware.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  # PUT /coursewares/1
  # PUT /coursewares/1.xml
  def update
    @courseware = Courseware.find(params[:id])
    render text:'无此课件' and return unless @courseware
    if !current_user.is_admin
			render text:'只能编辑自己的课件' and return unless current_user.id==@courseware.user_id
		end
		if params[:courseware][:quintessence] and current_user.is_admin
      @courseware.quintessence = params[:courseware][:quintessence]
    end
		build_form_elements
    respond_to do |format|
      if @courseware.update_attributes(params[:courseware])
        format.html { redirect_to(@courseware, :notice => 'Courseware was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @courseware.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  
  # DELETE /coursewares/1
  # DELETE /coursewares/1.xml
  def destroy
    @courseware = Courseware.find(params[:id])
    render text:'无此课件' and return unless @courseware
    if !current_user.is_admin
			render text:'只能删除自己的课件' and return unless current_user.id==@courseware.user_id
			render text:'24小时后不能删' and return if Time.now - @courseware.created_at > 3600*24
		end
    @courseware.destroy

    respond_to do |format|
      format.html { redirect_to(@courseware.course) }
      format.xml  { head :ok }
    end
  end



=begin
!!! ADMIN PAGE !!!
=end
  # GET /coursewares
  # GET /coursewares.xml
  def index
    render text:'admin only' and return unless current_user.is_admin
    @coursewares = Courseware.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @coursewares }
    end
  end

  
private
	def build_form_elements
    if @courseware.teacher_id
	    @teachers = Teaching.find_all_by_course_id(@courseware.course_id).collect{|teaching| [teaching.teacher.name,teaching.teacher_id]}
    else
    	@teachers = []
    end
		@resource = @courseware
	end

end
