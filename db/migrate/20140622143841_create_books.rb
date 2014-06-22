class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :url
      t.string :cover_url
      t.text :description
      t.string :publisher

      t.timestamps
    end
  end
end
