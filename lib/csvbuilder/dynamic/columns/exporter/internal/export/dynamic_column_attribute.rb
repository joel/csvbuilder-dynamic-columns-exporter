# frozen_string_literal: true

require "csvbuilder/dynamic/columns/core/internal/dynamic_column_attribute_base"

module Csvbuilder
  module Export
    class DynamicColumnAttribute < Csvbuilder::DynamicColumnAttributeBase
      def unformatted_value
        formatted_cells
      end

      def source_cells
        header_models.map { |header_model| call_process_cell(header_model) }
      end

      class << self
        def define_process_cell(row_model_class, column_name)
          super { |header_model| header_model }
        end
      end
    end
  end
end
