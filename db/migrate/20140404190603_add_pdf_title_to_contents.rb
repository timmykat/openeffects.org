class AddPdfTitleToContents < ActiveRecord::Migration
  def change
    add_column :contents, :pdf_title, :string
  end
end
