class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :request
      t.string :destination
      t.references :site, index: true, foreign_key: true, null: false
      t.index [:request, :site_id], unique: true

      t.timestamps null: false
    end
  end
end
