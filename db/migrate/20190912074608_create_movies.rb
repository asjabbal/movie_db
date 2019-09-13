class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :description
      t.integer :category, limit: 2
      t.attachment :image

      t.timestamps
    end
  end
end
