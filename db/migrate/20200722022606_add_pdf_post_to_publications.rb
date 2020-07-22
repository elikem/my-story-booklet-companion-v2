class AddPdfPostToPublications < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :pdf_posted, :boolean, default: false
  end
end
