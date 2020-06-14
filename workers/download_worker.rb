class DownloadWorker
  include Sidekiq::Worker
  sidekiq_options queue: "download_workers"

  def perform(publication_url, publication_filename)
    File.open("#{Rails.root}/storage/#{publication_filename}", "wb") do |file|
      file.write HTTParty.get(publication_url).body
    end
  end
end