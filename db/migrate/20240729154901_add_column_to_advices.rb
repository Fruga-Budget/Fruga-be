class AddColumnToAdvices < ActiveRecord::Migration[7.1]
  def change
    add_column :advices, :needs_total, :integer
    add_column :advices, :wants_total, :integer
    add_column :advices, :savings_total, :integer
  end
end
