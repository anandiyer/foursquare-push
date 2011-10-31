require 'net/http'
require 'twiliolib'


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
    @checkin = Checkin.new()
    
    if (params["checkin"])
      checkin_json = JSON.parse(params["checkin"])
      
      @checkin.checkin_id = checkin_json["id"]
      if (checkin_json["venue"])
        @checkin.venue_id = checkin_json["venue"]["id"]
      end
    end
    if (params["user"])
      user_json = JSON.parse(params["user"])
      @checkin.user_id = user_json["id"]
    end
    
    # DO SOMETHING
    @foursquare_venue_id = @checkin.venue_id
    @checkin.save
      
    @body = "Did you know Arkham City was rated A-MAZING by the crew at IGN? http://xbox360.ign.com/objects/055/055051.html"
    
    # Get the user we should be sending this to
    @provider = "foursquare"
    @uid = @checkin.user_id
    @conditions = "provider = \'#{@provider}\' AND uid = \'#{@uid}\'"
    @auth = User.find(:first, :conditions => @conditions)

    # If we have this user's phone number saved, send them a text
    if @auth && @auth.user.phone
      @phone = @auth.user.phone

      # SMS
      # Create a Twilio REST account object using your Twilio account ID and token
      account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    
      t = {
            'From' => CALLER_ID,
            'To'   => @phone,
            'Body' => @body
      }
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages",
            "POST", t)
          
    end
    
    respond_to do |format|
        format.html { redirect_to(@checkin, :notice => 'Checkin was successfully created.') }
        format.xml  { render :xml => @checkin, :status => :created, :location => @checkin }
        format.json  { render :json => @checkin, :status => :created, :location => @checkin }
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
