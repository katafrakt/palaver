# frozen_string_literal: true

require "hashids"

module Discussion
  module Utils
    class Slugger
      include Deps["utils.slug_provider"]

      def to_slug(num, string, id)
        hashids = Hashids.new(ENV["HASHIDS_SALT"])
        hash = hashids.encode(num, id)
        "#{slug_provider.call(string)}-#{hash}"
      end

      def decode_id(slug)
        hashids = Hashids.new(ENV["HASHIDS_SALT"])
        hashid = slug.split("-").last
        _num, id = hashids.decode(hashid)
        id
      end
    end
  end
end
