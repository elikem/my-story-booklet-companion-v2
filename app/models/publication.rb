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
      DownloadIdmlJob.perform_later(publication_url, publication_filename)
    end
  end
end
