class AddColumnToAdvices < ActiveRecord::Migration[7.1]
  def change
    add_column :advices, :total_income, :integer
  end
end
