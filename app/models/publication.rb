class Publication < ApplicationRecord
  after_save :download_publication, :notify_main_application

  def download_publication
    unless publication_url.nil?
      DownloadWorker.perform_async(publication_url, publication_filename)
    end
  end

  def notify_main_application

  end
end
