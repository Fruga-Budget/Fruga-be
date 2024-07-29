class CreateAdvice < ActiveRecord::Migration[7.1]
  def change
    create_table :advices do |t|
      t.json :needs
      t.json :wants
      t.json :savings
      t.integer :needs_total
      t.integer :wants_total
      t.integer :savings_total
      t.text :recommendation
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
