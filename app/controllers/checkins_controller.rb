class CheckinsController < ApplicationController
  # GET /checkins
  # GET /checkins.xml
  def index
    @checkins = Checkin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkins }
      format.json  { render :json => @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.xml
  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkin }
      format.json  { render :json => @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.xml
  def new
    @checkin = Checkin.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkin }
      format.json  { render :json => @checkin }
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.xml
  def create
    
    p "HERE!"
    @checkin = Checkin.new()
    @checkin.checkin_id = params[:checkin][:id]
    @checkin.venue_id = params[:checkin][:venue][:id]
    @checkin.user_id = params[:user][:id]

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to(@checkin, :notice => 'Checkin was successfully created.') }
        format.xml  { render :xml => @checkin, :status => :created, :location => @checkin }
        format.json  { render :json => @checkin, :status => :created, :location => @checkin }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
        format.json  { render :json => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.xml
  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to(@checkin, :notice => 'Checkin was successfully updated.') }
        format.xml  { head :ok }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkin.errors, :status => :unprocessable_entity }
        format.json  { render :json => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.xml
  def destroy
    @checkin = Checkin.find(params[:id])
    # @checkin.destroy

    respond_to do |format|
      format.html { redirect_to(checkins_url) }
      format.xml  { head :ok }
    end
  end
end
