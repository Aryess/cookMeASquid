require 'spec_helper'

describe "Recipe Pages" do
	subject {page}

  describe "index" do
    before { visit recipes_path }

    it { should have_title('All recipes')}
    it { should have_selector('h1', text: 'All recipes')}

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:recipe)}}
      after(:all) { Recipe.delete_all }

      it {should have_selector('div.pagination')}

      it "should list each recipe" do
        Recipe.paginate(page: 1, per_page: 15).each do |recipe| 
          page.should have_selector('li', text: recipe.name)
        end
      end
    end

    describe "delete links" do
      before {FactoryGirl.create(:recipe)}
      it {should_not have_link('delete')}

      describe "as an admin user" do
        let(:user) {FactoryGirl.create(:admin)}
        before do
          sign_in user
          visit recipes_path
        end
        
        it {should have_link('delete', href: recipe_path(Recipe.first))}

        it "should be able to delete a recipe" do
          expect {click_link('delete')}.to change(Recipe, :count).by(-1)
        end
      end
    end
  end

  describe "detail page" do
    describe "with valid recipe" do
    	let(:recipe) { FactoryGirl.create(:recipe)}
    	before { visit recipe_path(recipe) }

    	it { should have_content (recipe.name) }
    	it { should have_title (recipe.name) }
    end

    describe "with invalid recipe" do
      before { visit recipe_path(-1) }

      it { should have_title("Home") }
      it { should have_content("Nothing to see here") }
    end
  end

  describe "new recipe page" do
    let(:user) {FactoryGirl.create(:admin)}
    before do 
      sign_in user
      visit new_recipe_path 
    end

    let(:submit) { "Add recipe" }

    describe "with invalid information" do
      it "should not create a recipe" do
        expect { click_button submit }.not_to change(Recipe, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",               with: "Example recipe"
        fill_in "Short description",  with: "user@example.com"
        fill_in "Content",            with: "#{"foobar " * 200}"
        fill_in "Difficulty",         with: "2"
        fill_in "Serving",            with: "3"
      end

      it "should create a recipe" do
        expect { click_button submit }.to change(Recipe, :count).by(1)
      end
    end
  end

  describe "edit" do
    let(:recipe) { FactoryGirl.create(:recipe) }
    let(:user) { FactoryGirl.create(:admin)}
    before do
      sign_in user
      visit edit_recipe_path(recipe) 
    end

    describe "page" do
      it { should have_selector('h1',    text: "Update a recipe") }
      it { should have_title("Edit recipe") }
    end

    describe "with invalid information" do
      before do 
        fill_in "Difficulty",       with: ""
        click_button "Save changes" 
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "NewName"}
      let(:new_short) { "New Short description"}

      before do
        fill_in "Name",              with: new_name
        fill_in "Short description", with: new_short
        click_button "Save changes"
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(recipe.reload.name).to  eq new_name }
      specify { expect(recipe.reload.short).to eq new_short }
    end
  end
end
