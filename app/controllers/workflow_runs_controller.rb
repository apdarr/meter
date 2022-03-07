class WorkflowRunsController < ApplicationController
  before_action :set_workflow_run, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /workflow_runs or /workflow_runs.json
  def index
    @workflow_runs = WorkflowRun.all
  end

  # GET /workflow_runs/1 or /workflow_runs/1.json
  def show
  end

  # GET /workflow_runs/new
  def new
    @workflow_run = WorkflowRun.new
  end

  # GET /workflow_runs/1/edit
  def edit
  end

  # POST /workflow_runs or /workflow_runs.json
  def create
    WorkflowRunWorker.perform_async(workflow_run_params)
    @workflow_run = WorkflowRun.new(workflow_run_params)

    respond_to do |format|
      if @workflow_run.save
        format.html { redirect_to workflow_run_url(@workflow_run), notice: "Workflow job was successfully created." }
        format.json { render :show, status: :created, location: @workflow_run }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workflow_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workflow_runs/1 or /workflow_runs/1.json
  def update
    respond_to do |format|
      if @workflow_run.update(workflow_run_params)
        format.html { redirect_to workflow_run_url(@workflow_run), notice: "Workflow job was successfully updated." }
        format.json { render :show, status: :ok, location: @workflow_run }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workflow_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflow_runs/1 or /workflow_runs/1.json
  def destroy
    @workflow_run.destroy

    respond_to do |format|
      format.html { redirect_to workflow_runs_url, notice: "Workflow job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workflow_run
      @workflow_run = WorkflowRun.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workflow_run_params
      # params.require(:workflow_run).permit(:status, :runner_id, :labels, :minutes, :workflow_name, :repo, :org, :sender)
      json_string = params["payload"]
      hash = JSON.parse(json_string)
    end
end
