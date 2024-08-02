require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should have_many(:advices).dependent(:destroy) }
    it { should have_secure_password }
  end

  describe "validations" do
    subject { user = User.new(user_name: 'testuser', password: 'test123456')}
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should validate_uniqueness_of(:user_name) }
    it { should validate_confirmation_of(:password) }
    it { should validate_length_of(:password).is_at_least(10) }
  end
end