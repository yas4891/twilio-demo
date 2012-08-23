class SmsController < ApplicationController
  
  before_filter { @request_url = "#{request.protocol}#{request.host}:#{request.port}" }
  before_filter { @twilio_client = Twilio::Application.config.twilio_client}
  
  
  # GET /sms
  # GET /sms.json
  def index
    @sms = Sm.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms }
    end
  end

  # GET /sms/1
  # GET /sms/1.json
  def show
    @sms = Sm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sms }
    end
  end

  # GET /sms/new
  # GET /sms/new.json
  def new
    @sms = Sm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sms }
    end
  end

  # GET /sms/1/edit
  def edit
    @sms = Sm.find(params[:id])
  end

  # POST /sms
  # POST /sms.json
  def create
    @sms = Sm.new(params[:sm])

    respond_to do |format|
      if @sms.save
        @twilio_client.account.sms.messages.create(
          :from => "+4915705008633",
          :to =>@sms.number, 
          :body => @sms.text)
        format.html { redirect_to sms_url, notice: 'Sm was successfully created.' }
        format.json { render json: @sms, status: :created, location: @sms }
      else
        format.html { render action: "new" }
        format.json { render json: @sms.errors, status: :unprocessable_entity }
      end
    end
  end
  
  #
  # INCOMING SMS
  #
  def incoming
    @sms = Sm.new(text: params['Body'], number: params['From'], direction: 'in')
    
    @sms.save
    
    render text: "thanks for transmitting", status: 200
    
  end

  # PUT /sms/1
  # PUT /sms/1.json
  def update
    @sms = Sm.find(params[:id])

    respond_to do |format|
      if @sms.update_attributes(params[:sm])
        format.html { redirect_to @sms, notice: 'Sm was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sms.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms/1
  # DELETE /sms/1.json
  def destroy
    @sms = Sm.find(params[:id])
    @sms.destroy

    respond_to do |format|
      format.html { redirect_to sms_url }
      format.json { head :no_content }
    end
  end
end
