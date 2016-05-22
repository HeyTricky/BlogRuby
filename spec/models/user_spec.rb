require 'rails_helper'

RSpec.describe User, type: :model do

	it 'check isAdmin procedure' do
		@user = User.create(role_id: 1)
		expect(@user.isAdmin?).to be true
	end

	it 'check isModerator procedure' do
		@user = User.create(role_id: 3)
		expect(@user.isModerator?).to be true
	end


	describe 'valid user' do
		before { @user = FactoryGirl.create(:user) }

		subject{ @user }

		it {should respond_to(:name)}
		it {should respond_to(:email)}
		it {should respond_to(:password)}
		it {should respond_to(:role_id)}

		it { should be_valid }
	end

	describe 'invalid user' do
		before {@user = User.create}
		subject { @user }
		it { should_not be_valid }
	end

end
