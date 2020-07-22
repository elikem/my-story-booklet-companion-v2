# == Schema Information
#
# Table name: publications
#
#  id                   :integer          not null, primary key
#  pdf_filename         :string
#  pdf_generated        :boolean          default(FALSE), not null
#  pdf_posted           :boolean          default(FALSE)
#  pdf_url              :string
#  publication_filename :string
#  publication_number   :string
#  publication_url      :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
class Publication < ApplicationRecord
  after_create :download_publication

  # download idml file if there's a value in the publication_url field
  # download this after a publication is created. this happens when the core app POSTs 
  # publication details to the companion app.
  def download_publication
    unless publication_url.nil?
      DownloadIdmlJob.perform_later(publication_url, publication_filename)
    end
  end
end
