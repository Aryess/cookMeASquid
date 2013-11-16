require 'spec_helper'

describe "User pages" do
  subject {page}
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit users_path
    end

    it { should have_title('All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it {
        Rails.logger.debug "FFFail"
        Rails.logger.debug page.title
        should have_selector('div.pagination') 
        }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          page.should have_selector('li', text: user.login)
        end
      end 
    end
  end
  
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
      
      describe "after submission" do
        before { click_button submit }

        it { should have_title('Sign up') }
        it { should have_content('error') }
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
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('jdoe@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.login) }
        it { should have_selector('div.alert.alert-success', text: 'Registration successful') }
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit user") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_login)  { "NewName" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Login",            with: new_login
        fill_in "Email",            with: new_email
        fill_in "Password",         with: user.password
        fill_in "Confirmation",     with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_login) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      specify { expect(user.reload.login).to  eq new_login }
      specify { expect(user.reload.email).to eq new_email }
    end
  end
end
