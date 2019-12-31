class AlterPagesAndSectionsTable < ActiveRecord::Migration[5.2]
  def change
  	change_column :pages, :permalink, :string
  	change_column :sections, :content_type, :string
  	add_column :sections, :content, :text
  end
end
