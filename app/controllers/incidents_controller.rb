class IncidentsController < ApplicationController
  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.order("received DESC").all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incidents.to_json(:only => [:received_raw, :incident_description, :location, :latitude, :longitude, :priority]), :callback => params[:callback] }
    end
  end

  # GET /incidents/1
  # GET /incidents/1.json
  def show
    @incident = Incident.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @incident }
    end
  end

  # GET /incidents/unique.json
  def unique
    @incidents = Incident.all.map(&:incident_description).uniq
    respond_to do |format|
      format.json { render json: @incidents, :callback => params[:callback]  }
    end
  end

end
