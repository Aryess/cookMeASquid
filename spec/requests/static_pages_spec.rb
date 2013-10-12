require 'spec_helper'

describe "Static pages" do
  subject{ page }
  
  describe "Home page" do
    before { visit home_path }
    it {should have_selector('h1', text:"welcome")}
  end
  
  describe "Help page" do
    before { visit help_path }
    it {should have_selector('h1', text:"Are you lost?")}
  end
end