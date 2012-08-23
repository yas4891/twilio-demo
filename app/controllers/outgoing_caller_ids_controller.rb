class OutgoingCallerIdsController < ApplicationController
  
  before_filter { @request_url = "#{request.protocol}#{request.host}:#{request.port}" }
  before_filter { @twilio_client = Twilio::Application.config.twilio_client}
  
  # GET /outgoing_caller_ids
  # GET /outgoing_caller_ids.json
  def index
    @outgoing_caller_ids = OutgoingCallerId.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @outgoing_caller_ids }
    end
  end

  # GET /outgoing_caller_ids/1
  # GET /outgoing_caller_ids/1.json
  def show
    @outgoing_caller_id = OutgoingCallerId.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @outgoing_caller_id }
    end
  end

  # GET /outgoing_caller_ids/new
  # GET /outgoing_caller_ids/new.json
  def new
    @outgoing_caller_id = OutgoingCallerId.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @outgoing_caller_id }
    end
  end

  # GET /outgoing_caller_ids/1/edit
  def edit
    @outgoing_caller_id = OutgoingCallerId.find(params[:id])
  end

  # POST /outgoing_caller_ids
  # POST /outgoing_caller_ids.json
  def create
    @outgoing_caller_id = OutgoingCallerId.new(params[:outgoing_caller_id])
    @outgoing_caller_id.status = 'init'

    respond_to do |format|
      if @outgoing_caller_id.save
        url = "#{@request_url}/outgoing_caller_ids/#{ @outgoing_caller_id.id}/status_update"
        response = @twilio_client.account.outgoing_caller_ids.create(
          phone_number: @outgoing_caller_id.phone_number,
          status_callback: url,
          friendly_name: @outgoing_caller_id.friendly_name,
          call_delay: 5
        )
        
        @outgoing_caller_id.update_attribute :validation_code, response.validation_code
        format.html { redirect_to @outgoing_caller_id, notice: "Outgoing caller was successfully created. #{url}" }
        format.json { render json: @outgoing_caller_id, status: :created, location: @outgoing_caller_id }
      else
        format.html { render action: "new" }
        format.json { render json: @outgoing_caller_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /outgoing_caller_ids/1
  def status_update
    @outgoing_caller_id = OutgoingCallerId.find(params[:id])
    @outgoing_caller_id.update_attribute :status, params[:VerificationStatus]
    @outgoing_caller_id.update_attribute :sid, params[:OutgoingCallerIdSid]
    
    redirect_to @outgoing_caller_id
  end
  
  # PUT /outgoing_caller_ids/1
  # PUT /outgoing_caller_ids/1.json
  def update
    @outgoing_caller_id = OutgoingCallerId.find(params[:id])
    @outgoing_caller_id.update_attribute :status, params[:verification_status]
    @outgoing_caller_id.update_attribute :sid, params[:outgoing_caller_id_sid]
    
  end

  # DELETE /outgoing_caller_ids/1
  # DELETE /outgoing_caller_ids/1.json
  def destroy
    @outgoing_caller_id = OutgoingCallerId.find(params[:id])
    @outgoing_caller_id.destroy

    respond_to do |format|
      format.html { redirect_to outgoing_caller_ids_url }
      format.json { head :no_content }
    end
  end
end
