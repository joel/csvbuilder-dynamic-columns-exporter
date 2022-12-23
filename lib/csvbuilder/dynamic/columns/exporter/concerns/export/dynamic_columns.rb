# frozen_string_literal: true

require "csvbuilder/dynamic/columns/core/concerns/dynamic_columns_base"
require "csvbuilder/exporter/concerns/export/attributes"
require "csvbuilder/dynamic/columns/exporter/internal/export/dynamic_column_attribute"

module Csvbuilder
  module Export
    module DynamicColumns
      extend ActiveSupport::Concern
      include DynamicColumnsBase

      included do
        ensure_define_dynamic_attribute_method
      end

      def dynamic_column_attribute_objects
        @dynamic_column_attribute_objects ||= array_to_block_hash(self.class.dynamic_column_names) do |column_name|
          self.class.dynamic_attribute_class.new(column_name, self)
        end
      end

      # @return [Array] an array of public_send(column_name) of the CSV model
      def to_row
        super.flatten
      end

      class_methods do
        def dynamic_attribute_class
          DynamicColumnAttribute
        end
      end
    end
  end
end
