class InvestigationsController < ApplicationController
  include InvestigationsHelper
  helper_method :sort_column, :sort_direction

  before_action :set_search_params, only: %i[index]
  before_action :set_investigation, only: %i[show update assign status confirmation priority]

  # GET /investigations
  # GET /investigations.json
  # GET /investigations.xlsx
  def index
    @investigations = search_for_investigations(20)
  end

  # GET /investigations/1
  # GET /investigations/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @investigation.id.to_s
      end
    end
  end

  # GET /investigations/new
  def new
    @investigation = Investigation.new
  end

  # GET /investigations/1/status
  def status; end

  # GET /investigations/1/assign
  def assign; end

  # GET /investigations/1/confirmation
  def confirmation; end

  # GET /investigations/1/priority
  def priority; end

  # PATCH/PUT /investigations/1
  # PATCH/PUT /investigations/1.json
  def update
    ps = investigation_update_params
    @investigation.is_closed = ps[:is_closed] if ps[:is_closed]
    @investigation.priority = ps[:priority] if ps[:priority]
    @investigation.priority_rationale = ps[:priority_rationale] if ps[:priority_rationale]
    @investigation.assignee = User.find_by(id: ps[:assignee_id]) if ps[:assignee_id]
    respond_to do |format|
      if @investigation.save
        format.html { redirect_to @investigation, notice: "Investigation was successfully updated." }
        format.json { render :show, status: :ok, location: @investigation }
      else
        @investigation.restore_attributes
        origin = if ps[:is_closed]
                   :status
                 elsif ps[:priority]
                   :priority
                 else
                   :assign
                 end
        format.html { render origin }
        format.json { render json: @investigation.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /investigations
  # POST /investigations.json
  def create
    @investigation = Investigation.new(investigation_create_params)
    @investigation.source = UserSource.new(user: current_user)
    respond_to do |format|
      if @investigation.save
        format.html { redirect_to investigation_path(@investigation) }
        format.json { render :show, status: :created, location: @investigation }
      else
        format.html { render :new }
        format.json { render json: @investigation.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def set_investigation
    @investigation = Investigation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def investigation_create_params
    params.require(:investigation).permit(:description)
  end

  def investigation_update_params
    params.require(:investigation).permit(:is_closed, :assignee_id, :priority, :priority_rationale)
  end
end
