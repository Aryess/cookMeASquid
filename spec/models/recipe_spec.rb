require 'spec_helper'

describe Recipe do
  before { @recipe = Recipe.new(short: "Blahblahblahblah", 
    detail: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eget interdum augue. Duis cursus, lacus nec egestas hendrerit, nibh nibh vestibulum libero, a facilisis tellus nisi ut metus. Integer ac suscipit sem. Morbi magna erat, vulputate in massa ut, condimentum dapibus odio. Phasellus aliquet risus nunc, nec ornare enim fringilla vitae. Cras semper elit eu luctus molestie. Donec bibendum fermentum eros. Vivamus sodales tristique elit at accumsan. Sed in tellus euismod, accumsan purus pulvinar, suscipit sapien. Etiam vitae eros ligula. Etiam posuere neque ac scelerisque tempor. Phasellus gravida, ligula a cursus adipiscing, lectus lorem euismod enim, vel commodo nisl sem at arcu.

Donec auctor luctus porttitor. Nulla facilisi. Ut a eros felis. Donec mauris ipsum, mattis a aliquet eu, imperdiet ac ante. Duis placerat tellus sit amet dui dictum, interdum viverra dolor mattis. Vestibulum elementum mauris ligula, eget porta sapien pretium at. Donec dictum magna vel purus consequat, eget tincidunt lacus eleifend. Nullam dictum, lacus nec placerat vehicula, risus neque varius metus, faucibus accumsan sapien libero eget mauris. ", 
    difficulty: 5,
    name: "Blablah",
    serving: 3) }

  subject { @recipe }

  it { should respond_to(:short) }
  it { should respond_to(:detail) }
  it { should respond_to(:difficulty)}
  it { should be_valid }

  describe "when short" do
    describe "not present" do
      before { @recipe.short = " "}
      it { should_not be_valid }
    end

    describe "too short" do
      before { @recipe.short = "a"*5 }
      it { should_not be_valid }
    end

    describe "too long" do
      before { @recipe.short = "a"*41 }
      it { should_not be_valid }
    end
  end

  describe "when detail" do
    describe "not present" do
      before { @recipe.detail = " "}
      it { should_not be_valid }
    end

    describe "too short" do
      before { @recipe.detail = "a"*49 }
      it { should_not be_valid }
    end
  end

  describe "when difficulty" do
    describe "too low" do
      before { @recipe.difficulty = -1 }
      it { should_not be_valid }
    end

    describe "too high" do
      before { @recipe.difficulty = 6 }
      it { should_not be_valid }
    end
  end

  describe "when name" do
    describe "too long" do
      before { @recipe.name = "a"*36 }
      it { should_not be_valid }
    end

    describe "no present" do
      before { @recipe.name = " " }
      it { should_not be_valid }
    end

    describe "too short" do
      before { @recipe.name = "a"*4 }
      it { should_not be_valid }
    end
  end

  describe "when serving" do
    describe "to low" do
      before { @recipe.serving = -1 }
      it { should_not be_valid }
    end
  end
end 
