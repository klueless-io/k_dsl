class Campaign < ActiveRecord::Base
  def self.click_stats(campaign_ids, start_date, end_date)
    result = {
      total_trackers: 0,
      unique_clicks: 0
    }
    query = %Q{
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
    } 
    if campaign_ids.count > 0
      query_result = ActiveRecord::Base.connection.execute(query).first
      if query_result
        result = {
          total_trackers: query_result["total_trackers"].try(:to_i) || 0,
          unique_clicks: query_result["unique_clicks"].try(:to_i) || 0,
        }
      end
    end
    result
  end
end