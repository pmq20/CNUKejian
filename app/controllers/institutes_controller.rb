# -*- encoding : utf-8 -*-
class InstitutesController < ApplicationController
=begin
  # GET /institutes
  # GET /institutes.xml
  def index
    @institutes = Institute.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @institutes }
    end
  end

  # GET /institutes/1
  # GET /institutes/1.xml
  def show
    @institute = Institute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @institute }
    end
  end

  # GET /institutes/new
  # GET /institutes/new.xml
  def new
    @institute = Institute.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @institute }
    end
  end

  # GET /institutes/1/edit
  def edit
    @institute = Institute.find(params[:id])
  end

  # POST /institutes
  # POST /institutes.xml
  def create
    @institute = Institute.new(params[:institute])

    respond_to do |format|
      if @institute.save
        format.html { redirect_to(@institute, :notice => 'Institute was successfully created.') }
        format.xml  { render :xml => @institute, :status => :created, :location => @institute }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @institute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /institutes/1
  # PUT /institutes/1.xml
  def update
    @institute = Institute.find(params[:id])

    respond_to do |format|
      if @institute.update_attributes(params[:institute])
        format.html { redirect_to(@institute, :notice => 'Institute was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @institute.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /institutes/1
  # DELETE /institutes/1.xml
  def destroy
    @institute = Institute.find(params[:id])
    @institute.destroy

    respond_to do |format|
      format.html { redirect_to(institutes_url) }
      format.xml  { head :ok }
    end
  end
=end
end
