# SynchronizeService will synchronize data from google spreadsheets to the main database
class SynchronizeService

  DEFAULT_SOURCE = 'production'

  # --------------------------------------------------------------------------------
  # Synchronize ({{titleize (humanize settings.Application)}}) data
  # --------------------------------------------------------------------------------

{{#each models}}
  def self.{{snake this.names}}(sync: false, reset_table: false, spreadsheet_name: AppService::DEFAUT_SPREADSHEET_NAME, worksheet_name: '{{dashify this.name}}', source_key: DEFAULT_SOURCE)
    bulk_upsert = BulkUpsert::{{camelU this.name}}BulkUpsert.new

    upsert(bulk_upsert, sync, reset_table, spreadsheet_name, worksheet_name, source_key)
  end
{{/each}}

  
  # --------------------------------------------------------------------------------
  private
  # --------------------------------------------------------------------------------
  def self.upsert(bulk_upsert, sync, reset_table, spreadsheet_name, worksheet_name, source_key)
    if reset_table
      bulk_upsert.destroy_and_resequence_table
    end

    if sync
      bulk_upsert.sync(spreadsheet_name: spreadsheet_name, worksheet_name: worksheet_name, source_key: source_key)
    end
  end

end
