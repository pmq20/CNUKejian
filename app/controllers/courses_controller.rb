# -*- encoding : utf-8 -*-
class CoursesController < ApplicationController
  before_filter :authenticate_user!,:except=>[:show]
    
  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])
		@coursewares = @course.coursewares
		@coursewares = @coursewares.where('teacher_id=?',params[:teacher_id]) if params[:teacher_id]
		@coursewares = @coursewares.where('klass=?',params[:klass]) if params[:klass]
		unless @course.hidden
		  @coursewares = @coursewares.where('hidden=0')
		end
		@coursewares = @coursewares.where('assets_count>0').order('id+replies_count*2+purchases_count*10+quintessence*100 DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new
    @resource = @course
    render text:'参数不够' unless params[:q]
    @course.name = params[:q]
    
    respond_to do |format|
      format.html {render :layout=>'application'}
      format.xml  { render :xml => @course }
    end
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])
    @resource = @course
    @course.hidden = true
    @course.user_id = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new",:layout=>'application' }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

=begin
!!! ADMIN PAGE !!!
=end
  # GET /courses
  # GET /courses.xml
  def index
    render text:'admin only' and return unless current_user.is_admin
    @courses = Course.where('user_id is not NULL').order('created_at DESC')
    respond_to do |format|
      format.html {render(:layout=>'application')}
      format.xml  { render :xml => @courses }
    end
  end
  
  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    render text:'admin only' and return unless current_user.is_admin
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
=begin

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end


  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

=end
end
