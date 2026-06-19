# frozen_string_literal: true

module Discussion
  module Structs
    class CategoryListItem < Hanami::DB::Struct
      # temporary
      def latest_thread = nil
    end
  end
end
