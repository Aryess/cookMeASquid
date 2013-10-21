require 'spec_helper'

describe "User pages" do
  subject {page}
  
  describe "profile page" do
    
    describe "with valid user" do
      let(:user) { FactoryGirl.create(:user) }
      before { visit user_path(user) }
  
      it { should have_content(user.login) }
      it { should have_title(user.login) }
    end
    
    describe "with invalid user" do
      before { visit user_path(-1) }
  
      it { should have_title("Home") }
      it { should have_content("Nothing to see here") }
    end
  end
  
  describe "Signup page" do
    before {visit signup_path}
    it{should have_content "Sign up"}
    it{should have_title "Sign up"}
  end
end
