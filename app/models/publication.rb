# == Schema Information
#
# Table name: publications
#
#  id                   :integer          not null, primary key
#  pdf_generated        :boolean          default(FALSE), not null
#  publication_filename :string
#  publication_number   :string
#  publication_url      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Publication < ApplicationRecord
  after_create :download_publication

  def download_publication
    unless publication_url.nil?
      DownloadIDMLWorker.perform_async(publication_url, publication_filename)
    end
  end

  def self.post_pdf_to_core_app(pdf_filepath)
    # TODO: post pdf attachment to core/base/main app
    # POST Command via Sidekiq
    # get filename from pdf filepath
    # update publication object with pdf filepath
    # call Sidekiq to POST file to core app using HTTParty
    filename = File.basename(pdf_filepath)
    @publication = Publication.find_by_publication_filename(filename.gsub("pdf", "idml"))
    @publication.update(pdf_filepath: pdf_filepath)

    PostPDFPublicationWorker.perform_async(@publication.id, pdf_filepath)
  end
end
