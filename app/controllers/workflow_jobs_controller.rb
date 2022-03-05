class WorkflowJobsController < ApplicationController
  before_action :set_workflow_job, only: %i[ show edit update destroy ]

  # GET /workflow_jobs or /workflow_jobs.json
  def index
    @workflow_jobs = WorkflowJob.all
  end

  # GET /workflow_jobs/1 or /workflow_jobs/1.json
  def show
  end

  # GET /workflow_jobs/new
  def new
    @workflow_job = WorkflowJob.new
  end

  # GET /workflow_jobs/1/edit
  def edit
  end

  # POST /workflow_jobs or /workflow_jobs.json
  def create
    @workflow_job = WorkflowJob.new(workflow_job_params)

    respond_to do |format|
      if @workflow_job.save
        format.html { redirect_to workflow_job_url(@workflow_job), notice: "Workflow job was successfully created." }
        format.json { render :show, status: :created, location: @workflow_job }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @workflow_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workflow_jobs/1 or /workflow_jobs/1.json
  def update
    respond_to do |format|
      if @workflow_job.update(workflow_job_params)
        format.html { redirect_to workflow_job_url(@workflow_job), notice: "Workflow job was successfully updated." }
        format.json { render :show, status: :ok, location: @workflow_job }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @workflow_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflow_jobs/1 or /workflow_jobs/1.json
  def destroy
    @workflow_job.destroy

    respond_to do |format|
      format.html { redirect_to workflow_jobs_url, notice: "Workflow job was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workflow_job
      @workflow_job = WorkflowJob.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def workflow_job_params
      params.require(:workflow_job).permit(:status, :runner_id, :labels, :minutes, :workflow_name, :repo, :org, :sender)
    end
end
