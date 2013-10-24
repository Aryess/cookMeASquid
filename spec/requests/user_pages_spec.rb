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
  
  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Create my account" }

    it{should have_content "Sign up"}
    it{should have_title "Sign up"}
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Login",        with: "Jdoe"
        fill_in "Name",         with: "John"
        fill_in "Surname",      with: "Mc Doe"
        fill_in "Age",          with: 42
        fill_in "Email",        with: "jdoe@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
