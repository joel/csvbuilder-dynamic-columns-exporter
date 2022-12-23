# frozen_string_literal: true

require "csvbuilder/exporter/public/export"

require "csvbuilder/dynamic/columns/exporter/concerns/export/dynamic_columns"
Csvbuilder::Export.include(Csvbuilder::Export::DynamicColumns)
