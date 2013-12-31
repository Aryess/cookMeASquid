require 'spec_helper'

describe Comment do

  let(:user) { FactoryGirl.create(:user) }
  let(:recipe) { FactoryGirl.create(:recipe) }
  before { @comment = user.comments.build(content: "Lorem ipsum", rating: 3, recipe_id: recipe.id) }

  subject { @comment }

  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  it { should respond_to(:recipe_id) }
  it { should respond_to(:recipe) }
  its(:recipe) { should == recipe }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Comment.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is not present" do
    before { @comment.user_id = nil }
    it { should_not be_valid }
  end

  describe "when recipe_id is not present" do
    before { @comment.recipe_id = nil }
    it { should_not be_valid }
  end
end
