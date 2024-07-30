require 'rails_helper'

RSpec.describe Advice, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:needs) }
    it { should validate_presence_of(:wants) }
    it { should validate_presence_of(:savings) }
    it { should validate_presence_of(:needs_total) }
    it { should validate_presence_of(:wants_total) }
    it { should validate_presence_of(:savings_total) }
    it { should validate_presence_of(:recommendation) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:total_income) }
    it { should validate_numericality_of(:needs_total) }
    it { should validate_numericality_of(:wants_total) }
    it { should validate_numericality_of(:savings_total) }
    it { should validate_numericality_of(:user_id) }
    it { should validate_numericality_of(:total_income) }
  end
end