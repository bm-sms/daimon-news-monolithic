class CreateRedirectRules < ActiveRecord::Migration
  def change
    create_table :redirect_rules do |t|
      t.string :request_path
      t.string :destination
      t.references :site, index: true, foreign_key: true, null: false
      t.index [:request_path, :site_id], unique: true

      t.timestamps null: false
    end
  end
end
