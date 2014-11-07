class CreateCategorization < ActiveRecord::Migration
  def change
    create_table :categorizations, id: false do |t|
      t.integer :bookmark_id
      t.integer :hashtag_id
    end
  end
end
