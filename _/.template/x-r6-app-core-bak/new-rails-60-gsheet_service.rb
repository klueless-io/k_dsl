module Gsheet

  class GsheetService

    # attr_accessor :session
    attr_reader :spreadsheet

    # What spreadsheet would you like to open by name
    #
    # @param title: name of spreadsheet
    # @param config_key: name of configuration to use, defaults to {{settings.Application}}

    def initialize(title = nil, config_key = nil)
      if config_key.nil?
        config_key = '{{settings.Application}}'
      end

      @session = GoogleDrive::Session.from_config("config/google-config-#{config_key}.json")

      open_spreadsheet(title) unless title.nil?
    end

    # Get the name (title) of spreadsheet
    def name
      assert_valid_spreadsheet
      return @spreadsheet.name
    end

    # Open a connection to a spreadsheet by it's title
    def open_spreadsheet(title)
      @spreadsheet = @session.spreadsheet_by_title(title)
      return
    end

    # Open a worksheet from an already open spreadsheet by it's index (position)
    def get_ws_by_index(index)
      assert_valid_spreadsheet
      return @spreadsheet.worksheets[index]
    end

    # Open a worksheet from an already open spreadsheet by it's title
    def get_ws_by_title(title)
      assert_valid_spreadsheet
      return @spreadsheet.worksheet_by_title(title)
    end

    # Open list of worksheet titles from an already open spreadsheet by it's title
    def get_ws_titles()
      assert_valid_spreadsheet
      return @spreadsheet.worksheets.map { |ws| ws.title }
    end

    # Add a new worksheet
    def add_worksheet(title, max_rows = 100, max_cols = 20)
      @spreadsheet.add_worksheet(title, max_rows, max_cols)
    end

    private

    def assert_valid_spreadsheet
      raise 'You must open a connection to a spreadsheet before using this method' if @spreadsheet.nil?
    end
  end

end