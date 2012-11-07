class IncidentsController < ApplicationController
  # GET /incidents
  # GET /incidents.json
  def index
    @incidents = Incident.where("received > ?", Date.today - 1.days)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @incidents, :callback => params[:callback] }
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

end
