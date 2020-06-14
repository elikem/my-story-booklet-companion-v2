class PublicationsController < ApplicationController
  protect_from_forgery :except => [:download_idml_publication]

  # download a single idml publication
  def create_idml_publication
    @publication = Publication.new(publication_params)

    unless @publication.save
      Rails.logger.error "ERROR: Publication was not saved. #{@publication.errors.full_messages}"
    end
  end

  private

  def publication_params
    params.require(:publication).permit(:publication_number, :publication_url, :publication_filename, :publication_status)
  end
end
