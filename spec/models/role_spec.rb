require 'rails_helper'

RSpec.describe Role, type: :model do

	describe 'valid user' do
		before {@role = FactoryGirl.create(:role)}

		subject{@role}

		it { should be_valid }
	end
end
