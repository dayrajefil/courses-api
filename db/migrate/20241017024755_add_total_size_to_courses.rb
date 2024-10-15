class AddTotalSizeToCourses < ActiveRecord::Migration[7.1]
  def change
    add_column :courses, :total_size_in_mb, :float
  end
end
