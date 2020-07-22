class PublicationsController < ApplicationController
  protect_from_forgery :except => [:create_idml_publication]

  # download a single idml publication
  def download_idml_publication
    @publication = Publication.new(publication_params)

    unless @publication.save
      Rails.logger.error "ERROR: Publication was not saved. #{@publication.errors.full_messages}"
    end
  end

  # trigger informing companion app of a newly generated PDF file
  def new_pdf_alert
    # search for new files by looking for where a publication exists and a pdf_generated hasn't been generated.
    # when a new file is found, update the pdf_generated and pdf_filename column.
    Dir.glob("#{Rails.root}/storage/Out/*.pdf").each do |filename|
      publication_number = extract_publication_number_from(filename)
      publication = Publication.find_by_publication_number(publication_number)

      if publication && !publication.pdf_generated
        publication.update(pdf_generated: true, pdf_filename: filename, pdf_url: "#{CONFIG["companion_app_domain"]}/publications/#{publication.id}/pdf")
        PostPdfUrlToCoreJob.perform_later(publication.id)
      end
    end

    head :ok
  end

  # download link for pdf file to be consumed by the core app
  def show_pdf
    @publication = Publication.find(params[:id])
    send_file("#{@publication.pdf_filename}", type: "application/pdf", disposition: "attachment", stream: true, status: 200)
  end

  private

  def publication_params
    params.require(:publication).permit(:publication_number, :publication_url, :publication_filename, :publication_status)
  end

  # the filename and strip everything until you are left with just the publication number
  def extract_publication_number_from(file)
    file = file.gsub(/^.*\/Out\/.\d*-\d*-\d*-\d*-\d*-\d*-/, "").gsub(/-mystorybooklet-english.pdf/, "")
  end
end
