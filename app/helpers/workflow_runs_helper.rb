module WorkflowRunsHelper
    def current_billing_interval
        # Use the shared storage API as a proxy to determine the billing cycle
        remaining_billing_days = HTTParty.get("https://api.github.com/orgs/#{ENV['GH_ORG']}/settings/billing/shared-storage", {
            :headers => {"Accept" => "application/vnd.github.v3+json","Authorization" => "token #{ENV['GH_TOKEN']}"}
            }).to_hash.dig("days_left_in_billing_cycle")
        
        # GitHub's billing reset schedule is based on US Pacific time    
        now = Time.now.in_time_zone("Pacific Time (US & Canada)").to_date
        days_to_start_date = 31 - remaining_billing_days

        cycle_start_date = now - days_to_start_date
        cycle_end_date= now + remaining_billing_days

        "#{cycle_start_date.strftime("%Y/%m/%d")} - #{cycle_end_date.strftime("%Y/%m/%d")}"
    end
end
