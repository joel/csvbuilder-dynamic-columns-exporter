# frozen_string_literal: true

class DynamicColumnModel
  include Csvbuilder::Model

  column :first_name
  column :last_name
  dynamic_column :skills
end

#
# Export
#
class DynamicColumnExportModel < DynamicColumnModel
  include Csvbuilder::Export
end

class DynamicColumnExportWithFormattingModel < DynamicColumnModel
  include Csvbuilder::Export
  class << self
    def format_cell(cell, _column_name, _context)
      cell.upcase
    end
  end
end
