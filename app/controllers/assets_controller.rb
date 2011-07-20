# -*- encoding : utf-8 -*-
class AssetsController < ApplicationController
  before_filter :authenticate_user!,:check_ownership
  def show
    disposition = 'attachment'
    if params[:inline]
    	disposition = 'inline'
    end
		send_file @asset.data.path, :type => @asset.data_content_type,:disposition=>disposition,:url_based_filename=>true
  end
  
  def playflv
  	
  end
  
  def playwmv
  
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @asset.destroy
		render text:"$('#attachment_#{@asset.id}').remove()"
  end

private
	def check_ownership
    @asset = Asset.find(params[:id])
		render text:'无此文件记录' and return false unless @asset
		@courseware = @asset.courseware
		render text:'无此courseware记录' and return false unless @courseware
  	unless current_user
			session[:user_return_to]="/courses/#{@courseware.course_id}" 
			redirect_to '/users/sign_in' and return false
  	end
		unless current_user.is_admin or @courseware.user_id==current_user.id or 0==@courseware.price or Purchase.where(courseware_id:@courseware.id,user_id:current_user.id).count>0
    	render text:'请先购买' and return false
    end
    return true
	end
=begin
  # GET /assets
  # GET /assets.xml
  def index
    @assets = Asset.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.xml
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to(@asset, :notice => 'Asset was successfully created.') }
        format.xml  { render :xml => @asset, :status => :created, :location => @asset }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to(@asset, :notice => 'Asset was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @asset.errors, :status => :unprocessable_entity }
      end
    end
  end

=end
end
