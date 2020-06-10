class PublicationsController < ApplicationController
  protect_from_forgery :except => [:download_idml_publication]

  require "typhoeus"

  # download a single idml publication
  def create_idml_publication
    @publication = Publication.new(publication_params)

    if @publication.save
      puts "saved"
    else
      puts "failed"
    end
  end

  # respond to request to download a single idml
  def respond_to_request_to_download_idml
  end

  private

  def publication_params
    params.require(:publication).permit(:publication_number, :publication_url, :publication_filename, :publication_status)
  end
end
