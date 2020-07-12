class RemoveFilePath < ActiveRecord::Migration[5.2]
  def change
    remove_column :publications, :pdf_filepath
  end
end
