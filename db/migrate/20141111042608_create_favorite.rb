class CreateFavorite < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :user, index: true
      t.references :bookmark, index: true

      t.timestamps
    end
  end
end
