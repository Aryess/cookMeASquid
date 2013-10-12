require 'spec_helper'

describe "Static pages" do
  subject{ page }
  let(:base_title) { "Cook Me A Squid!" }
  
  describe "Home page" do
    before { visit home_path }
    it {should have_title("#{base_title} | Home")}
    it {should have_selector('h1', text:"Welcome")}
    
    it {should have_link("Home", href: home_path)}
    it {should have_link("Help", href: help_path)}
  end
  
  describe "Help page" do
    before { visit help_path }
    it {should have_title("#{base_title} | Help")}
    it {should have_selector('h1', text:"Are you lost?")}
    
    it {should have_link("Home", href: home_path)}
    it {should have_link("Help", href: help_path)}
  end
end