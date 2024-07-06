class CreateAdvice < ActiveRecord::Migration[7.1]
  def change
    create_table :advices do |t|
      t.integer :needs
      t.integer :wants
      t.integer :savings
      t.integer :total_income, null: false
      t.text :recommendation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
