class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.references :course, null: false, foreign_key: true
      t.text :url
      t.decimal :size_in_mb

      t.timestamps
    end
  end
end
