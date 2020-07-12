class CreatePdfGenerated < ActiveRecord::Migration[5.2]
  def change
   add_column :publications, :pdf_generated, :boolean, null: false, default: false
  end
end
