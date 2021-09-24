module Campaigns
  class DashboardController
    def show
      clicks = Campaigns::ClickStatisticsPresenter
                .new(campaign_ids: [1,2,3],
                    start_date: Date.today.at_beginning_of_month,
                    end: Date.today)
                .present

      @dashboard = { click_statistics: clicks, other_info: goes_here() }
    end
  end
end

