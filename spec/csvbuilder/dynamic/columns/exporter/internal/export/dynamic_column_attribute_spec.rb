# frozen_string_literal: true

require "spec_helper"

module Csvbuilder
  module Export
    RSpec.describe DynamicColumnAttribute do
      describe "instance" do
        let(:instance) { described_class.new(:skills, row_model) }
        let(:row_model_class) do
          Class.new do
            include Csvbuilder::Model
            include Csvbuilder::Export
            dynamic_column :skills
          end
        end
        let(:row_model) { row_model_class.new(nil, skills: Skill.all) }

        it_behaves_like "has_needed_value_methods", Csvbuilder::DynamicColumnsBase

        describe "#unformatted_value" do
          subject(:unformatted_value) { instance.unformatted_value }

          it "calls formatted_cells" do
            expect(instance).to receive(:formatted_cells)
            unformatted_value
          end
        end

        describe "#formatted_cells" do
          open_struct = OpenStruct.new(skills: Skill.all)
          it_behaves_like "formatted_cells_method", Csvbuilder::Export, [
            "Ruby__skills__#{open_struct}",
            "Python__skills__#{open_struct}",
            "Java__skills__#{open_struct}",
            "Rust__skills__#{open_struct}",
            "Javascript__skills__#{open_struct}",
            "GoLand__skills__#{open_struct}"
          ]
        end

        describe "#source_cells" do
          subject(:source_cells) { instance.source_cells }

          it "returns an array of unformatted_cell" do
            expect(instance).to receive(:header_models).and_call_original
            expect(source_cells).to eql Skill.all
          end

          context "with process method defined" do
            before do
              row_model_class.class_eval do
                def skill(header_model)
                  "__#{header_model}"
                end
              end
            end

            it "return an array of the result of the process method" do
              expect(source_cells).to eql %w[__Ruby __Python __Java __Rust __Javascript __GoLand]
            end
          end
        end

        describe "class" do
          describe "::define_process_cell" do
            subject(:define_process_cell) { described_class.define_process_cell(klass, :somethings) }

            let(:klass) { Class.new { include Csvbuilder::Proxy } }

            it "adds the process method to the class" do
              define_process_cell
              expect(klass.new.something("a")).to eql "a"
            end
          end
        end
      end
    end
  end
end
