# This migration comes from login_engine (originally 20140302085753)
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
  def down
  	drop_table :users
  end
end
