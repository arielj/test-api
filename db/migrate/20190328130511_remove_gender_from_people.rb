class RemoveGenderFromPeople < ActiveRecord::Migration[5.2]
  def change
    remove_column :people, :gender
  end
end
