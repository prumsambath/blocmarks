class CreateUnsignedUpUsers < ActiveRecord::Migration
  def change
    create_table :unsigned_up_users do |t|
      t.string :name
      t.string :email
      t.integer :email_received_count, default: 1

      t.timestamps
    end
  end
end
