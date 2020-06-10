class CreatePublications < ActiveRecord::Migration[5.2]
  def change
    create_table :publications do |t|
      t.string :publication_number
      t.string :publication_url
      t.string :publication_filename

      t.timestamps
    end
  end
end