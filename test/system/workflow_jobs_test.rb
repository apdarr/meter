require "application_system_test_case"

class WorkflowJobsTest < ApplicationSystemTestCase
  setup do
    @workflow_run = workflow_runs(:one)
  end

  test "visiting the index" do
    visit workflow_runs_url
    assert_selector "h1", text: "Workflow Jobs"
  end

  test "creating a Workflow job" do
    visit workflow_runs_url
    click_on "New Workflow Job"

    fill_in "Labels", with: @workflow_run.labels
    fill_in "Minutes", with: @workflow_run.minutes
    fill_in "Org", with: @workflow_run.org
    fill_in "Repo", with: @workflow_run.repo
    fill_in "Runner", with: @workflow_run.runner_id
    fill_in "Sender", with: @workflow_run.sender
    fill_in "Status", with: @workflow_run.status
    fill_in "Workflow name", with: @workflow_run.workflow_name
    click_on "Create Workflow job"

    assert_text "Workflow job was successfully created"
    click_on "Back"
  end

  test "updating a Workflow job" do
    visit workflow_runs_url
    click_on "Edit", match: :first

    fill_in "Labels", with: @workflow_run.labels
    fill_in "Minutes", with: @workflow_run.minutes
    fill_in "Org", with: @workflow_run.org
    fill_in "Repo", with: @workflow_run.repo
    fill_in "Runner", with: @workflow_run.runner_id
    fill_in "Sender", with: @workflow_run.sender
    fill_in "Status", with: @workflow_run.status
    fill_in "Workflow name", with: @workflow_run.workflow_name
    click_on "Update Workflow job"

    assert_text "Workflow job was successfully updated"
    click_on "Back"
  end

  test "destroying a Workflow job" do
    visit workflow_runs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Workflow job was successfully destroyed"
  end
end
