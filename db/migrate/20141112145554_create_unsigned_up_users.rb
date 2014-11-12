class CreateUnsignedUpUsers < ActiveRecord::Migration
  def change
    create_table :unsigned_up_users do |t|
      t.string :name
      t.string :email
      t.boolean :replied, default: false

      t.timestamps
    end
  end
end
