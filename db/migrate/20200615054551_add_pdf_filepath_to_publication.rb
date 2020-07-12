class AddPdfFilepathToPublication < ActiveRecord::Migration[5.2]
  def change
    add_column :publications, :pdf_filepath, :string
  end
end
