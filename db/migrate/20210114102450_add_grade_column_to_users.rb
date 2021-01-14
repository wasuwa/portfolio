class AddGradeColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :grade, :integer
  end
end
