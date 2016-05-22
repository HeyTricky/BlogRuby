require 'rails_helper'

RSpec.describe Comment, type: :model do
    describe 'valid comment' do
	before (:all) do
		@comment = FactoryGirl.create(:comment)
	end

	subject { @comment }
    	it { should respond_to :body }
	it { should respond_to :post_id }
    	it { should respond_to :user_id }
	it { should be_valid }
  end

  describe 'invalid comment' do

	context "when post_id is nil" do
		before {@comment = Comment.new(body: 'test body', post_id: nil, user_id: 1)}
		subject { @comment }
		it { should_not be_valid }	
	end

	context "when user_id is nil" do
		before {@comment = Comment.new(body: 'test body', post_id: 1, user_id: nil)}
		subject { @comment }
		it { should_not be_valid }
	end
  end
end
