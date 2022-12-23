# frozen_string_literal: true

require "spec_helper"

module Csvbuilder
  RSpec.describe Export do
    let(:klass) do
      Class.new do
        include Csvbuilder::Export
      end
    end

    it do
      expect(klass.included_modules).to include(Csvbuilder::Model::DynamicColumns)
    end
  end
end
