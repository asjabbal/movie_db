class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
    	t.timestamps
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true
      t.integer :rating, limit: 1
    end
  end
end
