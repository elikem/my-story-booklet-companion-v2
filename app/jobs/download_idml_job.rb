class DownloadIdmlJob < ApplicationJob
  queue_as :download_idml

  def perform(publication_url, publication_filename)
    File.open("#{Rails.root}/storage/#{publication_filename}", "wb") do |file|
      file.write HTTParty.get(publication_url).body
    end
  end
end
