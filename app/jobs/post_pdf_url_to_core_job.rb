class PostPdfUrlToCoreJob < ApplicationJob
  queue_as :post_pdf_url_to_core

  def perform(publication_id)
    # POST w/ HTTParty using both the publication_number, pdf_url
    @publication = Publication.find(publication_id)
    post_pdf_publication_endpoint = "#{CONFIG["core_app_url"]}/publications/publish-pdf"

    response = HTTParty.post(
      post_pdf_publication_endpoint,
      body: {
        publication: {
          publication_number: @publication.publication_number,
          pdf_url: @publication.pdf_url,
        },
      },
    )

    # Status Code 204 - No Content
    unless response.code == "204"
      # TODO: create a pdf_posted column for when a pdf is posted and the response from the core app is OK. this allows us to
      # retry posting until it is successful.
      # log response
      Rails.logger.error "ERROR: Post PDF to Core app failed. HTTP Status Code #{response.code} at #{Time.now}"
    end
  end
end
