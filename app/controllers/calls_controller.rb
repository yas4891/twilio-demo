class CallsController < ApplicationController
  
  before_filter { @request_url = "#{request.protocol}#{request.host}:#{request.port}" }
  before_filter { @twilio_client = Twilio::Application.config.twilio_client}
  
  # GET /calls
  # GET /calls.json
  def index
    @calls = Call.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calls }
    end
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
    @call = Call.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call }
    end
  end

  # GET /calls/new
  # GET /calls/new.json
  def new
    @call = Call.new
    @templates = Array.new
    Dir.new("app/views/calls/twiml").entries.each do |entry|
      @templates.push(entry[0..(entry.index('.') - 1)]) if (entry.ends_with? "xml.erb")
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call }
    end
  end

  # GET /calls/1/edit
  def edit
    @call = Call.find(params[:id])
  end

  # POST /calls
  # POST /calls.json
  def create
    @call = Call.new(params[:call])
    
    respond_to do |format|
      if @call.save
        
        result = OutgoingCallerId.find(:last)
        twcall = @twilio_client.account.calls.create(
          from: result.phone_number,
          to: @call.to, 
          url: "#{url_for(@call)}/twiml.xml")
        
        @call.update_attribute :sid, twcall.sid
        format.html { redirect_to @call, notice: "Call was successfully created.#{url_for(@call)}" }
        format.json { render json: @call, status: :created, location: @call }
      else
        format.html { render action: "new" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /calls/1
  # PUT /calls/1.json
  def update
    @call = Call.find(params[:id])

    respond_to do |format|
      if @call.update_attributes(params[:call])
        format.html { redirect_to @call, notice: 'Call was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @call = Call.find(params[:id])
    @call.destroy

    respond_to do |format|
      format.html { redirect_to calls_url }
      format.json { head :no_content }
    end
  end
  
  # GET /calls/:id/twiml
  def twiml
    @call = Call.find(params[:id])
    
    respond_to do |format|
      format.xml {render "calls/twiml/#{@call.template}"}  
    end
  end
  
  # POST /calls/:id/gather
  def gather
    @call = Call.find(params[:id])
    @call.update_attribute :gathered_numbers, params[:Digits] || @call.gathered_numbers
    
    render "calls/twiml/gather/#{@call.template}.xml.erb"
  end
  
  # GET / POST /calls/:id/recording
  def recording
    @call = Call.find(params[:id])
    @call.update_attribute :recording_url, params[:RecordingUrl] || @call.recording_url
    @call.update_attribute :recording_duration, params[:RecordingDuration] || @call.recording_duration
    
    render "calls/twiml/recording/#{@call.template}.xml.erb"
  end
  
  # GET / POST /calls/:id/transcribe
  def transcribe
    @call = Call.find(params[:id])
    @call.update_attribute :transcription_text, params[:TranscriptionText] || @call.transcription_text
    @call.update_attribute :transcription_status, params[:TranscriptionStatus] || @call.transcription_status
    
    render "calls/twiml/recording/#{@call.template}.xml.erb"
  end
  
  # GET /calls/update_calls
  def update_calls
    @calls = Call.all
    
    @calls.each do |call|
        next unless call.sid

        call.update_attribute :status, @twilio_client.account.calls.get(call.sid).status
        call.update_attribute :price, @twilio_client.account.calls.get(call.sid).price
    end
    
    respond_to do |format|
      format.html {redirect_to calls_url}
      format.json { render json: @calls }
    end
  end 
   
end
