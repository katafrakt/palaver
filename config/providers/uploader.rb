# frozen_string_literal: true

Hanami.app.register_provider :uploader do
  prepare do
    require "shrine"
    require "shrine/storage/file_system"
    
    Shrine.storages = { 
      cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary 
      store: Shrine::Storage::FileSystem.new("public", prefix: "uploads"),       # permanent 
    }

    Shrine.plugin :rom
    Shrine.plugin :rack_file
    Shrine.plugin :cached_attachment_data
    Shrine.plugin :restore_cached_data
    Shrine.plugin :form_assign 
    Shrine.plugin :validation_helpers 

    register :uploader, Shrine
  end
end