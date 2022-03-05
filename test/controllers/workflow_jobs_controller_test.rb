require "test_helper"

class WorkflowJobsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workflow_job = workflow_jobs(:one)
  end

  test "should get index" do
    get workflow_jobs_url
    assert_response :success
  end

  test "should get new" do
    get new_workflow_job_url
    assert_response :success
  end

  test "should create workflow_job" do
    assert_difference('WorkflowJob.count') do
      post workflow_jobs_url, params: { workflow_job: { labels: @workflow_job.labels, minutes: @workflow_job.minutes, org: @workflow_job.org, repo: @workflow_job.repo, runner_id: @workflow_job.runner_id, sender: @workflow_job.sender, status: @workflow_job.status, workflow_name: @workflow_job.workflow_name } }
    end

    assert_redirected_to workflow_job_url(WorkflowJob.last)
  end

  test "should show workflow_job" do
    get workflow_job_url(@workflow_job)
    assert_response :success
  end

  test "should get edit" do
    get edit_workflow_job_url(@workflow_job)
    assert_response :success
  end

  test "should update workflow_job" do
    patch workflow_job_url(@workflow_job), params: { workflow_job: { labels: @workflow_job.labels, minutes: @workflow_job.minutes, org: @workflow_job.org, repo: @workflow_job.repo, runner_id: @workflow_job.runner_id, sender: @workflow_job.sender, status: @workflow_job.status, workflow_name: @workflow_job.workflow_name } }
    assert_redirected_to workflow_job_url(@workflow_job)
  end

  test "should destroy workflow_job" do
    assert_difference('WorkflowJob.count', -1) do
      delete workflow_job_url(@workflow_job)
    end

    assert_redirected_to workflow_jobs_url
  end
end
