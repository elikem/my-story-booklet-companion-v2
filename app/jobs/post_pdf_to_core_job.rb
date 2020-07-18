class PostPdfToCoreJob < ApplicationJob
  queue_as :post_pdf_to_core
  
  def perform(publication_id, pdf_filepath)
    # POST w/ HTTParty using both the publication_number, pdf_filepath
    # POST pdf binary file, not pdf filepath as a string
    @publication = Publication.find(publication_id)
    post_pdf_publication_endpoint = "#{CONFIG["core_app_domain"]}/publications/publish-pdf"

    response = HTTParty.post(
      post_pdf_publication_endpoint,
      body: {
        publication: {
          publication_number: @publication.publication_number,
          pdf_file: File.read(pdf_filepath),
        },
      },
    )

    # Status Code 204 - No Content
    unless response.code == "204"
      # log response
      Rails.logger.error "ERROR: Post PDF to Core app failed. HTTP Status Code #{response.code} at #{Time.now}"
    end
  end
end
