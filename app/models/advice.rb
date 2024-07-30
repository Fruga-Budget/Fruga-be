class Advice < ApplicationRecord
  belongs_to :user

  validates_presence_of :needs
  validates_presence_of :wants
  validates_presence_of :savings
  validates_presence_of :needs_total
  validates_presence_of :wants_total
  validates_presence_of :savings_total
  validates_presence_of :recommendation
  validates_presence_of :user_id
  validates_presence_of :total_income
  validates_numericality_of :needs_total
  validates_numericality_of :wants_total
  validates_numericality_of :savings_total
  validates_numericality_of :user_id
  validates_numericality_of :total_income
end