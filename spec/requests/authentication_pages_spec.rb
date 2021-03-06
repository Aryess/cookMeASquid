require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
    
    describe "signin" do
      before { visit signin_path }
  
      describe "with invalid information" do
        before { click_button "Sign in" }
  
        it { should have_title('Sign in') }
        it { should_not have_link('Sign out',    href: signout_path) }
        it { should have_selector('div.alert.alert-error', text: 'Invalid') }
        describe "after visiting another page" do
          before { click_link "Home" }
          it { should_not have_selector('div.alert.alert-error') }
        end
      end
      
      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Sign in"
        end
        
        describe "then trying to access in controller" do
          describe "new user" do
            before do
              sign_in user
              get new_user_path
            end
            specify { expect(response).to redirect_to(root_path) }
          end

          describe "create user" do
            before do
              sign_in user
              post users_path
            end
            specify { expect(response).to redirect_to(root_path) }
          end
        end

        it { should have_link('Profile',     href: user_path(user)) }
        it { should have_link('Sign out',    href: signout_path) }
        it { should have_link('Settings',    href: edit_user_path(user)) }
        it { should_not have_link('Sign in', href: signin_path) }
        
        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link('Sign in') }
        end
      end
    end
  end
  
  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            Rails.logger.debug "Handlehandle"
            Rails.logger.debug page.title
            page.should have_title('Edit user')
          end
        end
      end
      
      describe "in the Users controller" do
    
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign in') }
        end
        
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

      describe "in the Recipes controller" do
        let(:recipe) { FactoryGirl.create(:recipe) }

        describe "visiting the edit page" do
          before {visit edit_recipe_path(recipe)}
          it { should have_title('Sign in')}
        end

        describe "submitting to the update action" do
          before { put recipe_path(recipe) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, login:"wrong", email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('title', text: 'Edit user') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_url) }
      end
    end

    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }
      let(:recipe) { FactoryGirl.create(:recipe)}

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(root_url) }
      end

      describe "visit edit recipe" do
        before { visit edit_recipe_path(recipe) }
        it { should_not have_title("Edit") }
      end

      describe "submitting a PUT request to the Recipes#update action" do
        before { put recipe_path(recipe) }
        specify { response.should redirect_to(root_url) }
      end

      describe "submitting a DELETE request to the Recipes#destroy action" do
        before { delete recipe_path(recipe) }
        specify { response.should redirect_to(root_url) }
      end
    end
  end
end