require "test_helper"

class WorkflowRunsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workflow_run = workflow_runs(:one)
  end

  test "should get index" do
    get workflow_runs_url
    assert_response :success
  end

  test "should get new" do
    get new_workflow_run_url
    assert_response :success
  end

  test "should create workflow_run" do
    assert_difference('WorkflowRun.count') do
      post workflow_runs_url, params: { workflow_run: { labels: @workflow_run.labels, minutes: @workflow_run.minutes, org: @workflow_run.org, repo: @workflow_run.repo, runner_id: @workflow_run.runner_id, sender: @workflow_run.sender, status: @workflow_run.status, workflow_name: @workflow_run.workflow_name } }
    end

    assert_redirected_to workflow_run_url(WorkflowRun.last)
  end

  test "should show workflow_run" do
    get workflow_run_url(@workflow_run)
    assert_response :success
  end

  test "should get edit" do
    get edit_workflow_run_url(@workflow_run)
    assert_response :success
  end

  test "should update workflow_run" do
    patch workflow_run_url(@workflow_run), params: { workflow_run: { labels: @workflow_run.labels, minutes: @workflow_run.minutes, org: @workflow_run.org, repo: @workflow_run.repo, runner_id: @workflow_run.runner_id, sender: @workflow_run.sender, status: @workflow_run.status, workflow_name: @workflow_run.workflow_name } }
    assert_redirected_to workflow_run_url(@workflow_run)
  end

  test "should destroy workflow_run" do
    assert_difference('WorkflowRun.count', -1) do
      delete workflow_run_url(@workflow_run)
    end

    assert_redirected_to workflow_runs_url
  end
end
