class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :orginal_url
      t.string :shorty
      t.integer :user_id
      t.integer :visit_count

      t.timestamps
    end
  end
end
