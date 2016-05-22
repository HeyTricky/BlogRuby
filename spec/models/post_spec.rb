require 'rails_helper'

RSpec.describe Post, type: :model do

  describe 'valid post' do
	before (:all) do
		@post = FactoryGirl.create(:post)
	end

	subject { @post }
    	it { should respond_to :title }
	it { should respond_to :text }
    	it { should respond_to :user_id }
	it { should be_valid }
  end

  describe 'invalid post' do

	context "when length of name < 5" do
		before {@post = Post.new(title: 'test', text: 'test', user_id: 1)}
		subject { @post }
		it { should_not be_valid }	
	end

	context "when user_id is nil" do
		before {@post = Post.new(title: 'title test', text: 'test', user_id: nil)}
		subject { @post }
		it { should_not be_valid }
	end
  end
end
