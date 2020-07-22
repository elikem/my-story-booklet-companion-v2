class AddPdfUrlToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :pdf_url, :string
    add_column :publications, :pdf_filename, :string
  end
end
