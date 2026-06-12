# frozen_string_literal: true

require "hashids"
require "diaeresis"

module Discussion
  module Utils
    class Slugger
      def to_slug(num, string, id)
        hashids = Hashids.new(ENV["HASHIDS_SALT"])
        hash = hashids.encode(num, id)
        slug = Diaeresis.to_url(string)
        "#{slug}-#{hash}"
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
