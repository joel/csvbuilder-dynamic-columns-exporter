# frozen_string_literal: true

module WithThisThenContext
  extend ActiveSupport::Concern
  include WithContext

  class_methods do
    # with_context "context_name1", "context_name1" { <block> }
    # is short hand for:
    # <block>
    # with_context "context_name1", "context_name1"
    def with_this_then_context(*context_names, &)
      instance_exec(&)
      with_context(*context_names, &)
    end
  end
end
