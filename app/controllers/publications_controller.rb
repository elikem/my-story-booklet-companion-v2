class PublicationsController < ApplicationController
  protect_from_forgery :except => [:create_idml_publication]

  # download a single idml publication
  def create_idml_publication
    @publication = Publication.new(publication_params)

    unless @publication.save
      Rails.logger.error "ERROR: Publication was not saved. #{@publication.errors.full_messages}"
    end
  end

  # trigger informing companion app of a newly generated PDF file
  def new_pdf_alert
    # TODO: Call background worker to:
    # search for new files
    # update the pdf_generated column
    # and then POST the PDF to the core app -> use Publication#post_pdf_to_core_app.
    Dir.glob("#{Rails.root}/storage/Out/*.pdf").each do |file|
      publication_number = extract_publication_number_from(file)
      publication = Publication.find_by_publication_number(publication_number)

      if publication && !publication.pdf_generated
        publication.update(pdf_generated: true)
        PostPDFPublicationWorker.perform_async(publication.id, file)
      end
    end

    head :ok
  end

  private

  def publication_params
    params.require(:publication).permit(:publication_number, :publication_url, :publication_filename, :publication_status)
  end

  def extract_publication_number_from(file)
    file = file.gsub(/^.*\/Out\/.\d*-\d*-\d*-\d*-\d*-\d*-/, "").gsub(/-mystorybooklet-english.pdf/, "")
  end
end
