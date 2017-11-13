class CreateBreedTags < ActiveRecord::Migration[5.1]
  def change
    create_table :breed_tags do |t|
      t.integer :breed_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
