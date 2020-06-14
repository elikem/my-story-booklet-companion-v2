class DownloadWorker
  include Sidekiq::Worker
  sidekiq_options queue: "download_workers"

  def perform(publication_id)
    # do something
  end
end