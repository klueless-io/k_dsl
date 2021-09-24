module Campaigns
  class ClickStatisticsPresenter < BasePresenter

    attr_reader :total_tracker
    attr_reader :unique_clicks

    delegate :campaign_ids, :start_date, :end_date, to: :shared_context
    
    def present
      query
      
      OpenStruct.new(
        total_trackers: total_trackers || 0,
        unique_clicks: unique_clicks || 0
      )
    end

    private

    def query
      return if campaign_ids.count.zero?

      result = ActiveRecord::Base.connection.execute(sql).first

      return unless result

      @total_trackers = query_result["total_trackers"].try(:to_i)
      @unique_clicks = query_result["unique_clicks"].try(:to_i)
    end

    def sql
      <<-SQL
        SELECT
          COUNT(tracker_hits.tracker_id) AS total_trackers,
          COUNT(DISTINCT tracker_hits.tracker_id) AS unique_clicks
        FROM trackers
        INNER JOIN campaign_messages_trackers ON campaign_messages_trackers.tracker_id = trackers.id
        INNER JOIN campaign_messages ON campaign_messages.id = campaign_messages_trackers.campaign_message_id
        LEFT OUTER JOIN tracker_hits ON tracker_hits.tracker_id = trackers.id
        WHERE trackers.method != 0
        AND trackers.path NOT LIKE '%unsubscribe%'
        AND campaign_messages.campaign_id IN (#{campaign_ids.to_csv})
        AND tracker_hits.created_at BETWEEN '#{start_date}'::timestamp AND '#{end_date}'::timestamp
      SQL
    end
  end
end
