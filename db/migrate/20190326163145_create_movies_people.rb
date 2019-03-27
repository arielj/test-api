class CreateMoviesPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :movies_people, id: false do |t|
      t.references :movie, index: true
      t.references :person, index: true
      t.integer :role
    end
  end
end
