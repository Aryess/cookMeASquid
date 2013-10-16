#!/bin/env ruby
# encoding: utf-8
require 'spec_helper'

describe User do

  before { @user = User.new(
    name:   "Alfred",
    surname:"Dupond",
    email:  "alfred.dupond@gmail.com",
    age: 34,
    login: "Fredo",
    password: "foobar", 
    password_confirmation: "foobar"
    ) 
  }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:surname) }
  it { should respond_to(:email) }
  it { should respond_to(:age) }
  it { should respond_to(:login) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should be_valid }
  
  describe "Name" do
    describe "When not present" do
      before {@user.name = " "}
      it {should_not be_valid}
    end
    
    describe "When too long" do
      before { @user.name = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "When has incorrect char" do
      it "should be invalid" do
        names = ["use\"uoo", "zz(ehrzer", "ger_ur", "ur$zr", "zerree4e", "utr<rt"]
        names.each do |invalid_name|
          @user.surname = invalid_name
          expect(@user).not_to be_valid
        end
      end
    end
  end
  
  
   describe "Surname" do
    describe "When not present" do
      before {@user.surname = " "}
      it {should_not be_valid}
    end
    
    describe "when irish" do
      before {@user.surname = "Mc M'achin-truc"}
      it { should be_valid}
      
    end
    describe "When too long" do
      before { @user.surname = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "When has incorrect char" do
      it "should be invalid" do
        names = ["use\"uoo", "zz(ehrzer", "ger_ur", "ur$zr", "zerree4e", "utr<rt"]
        names.each do |invalid_name|
          @user.surname = invalid_name
          expect(@user).not_to be_valid
        end
      end
    end
  end
  
  describe "email" do
    describe "When not present" do
      before {@user.email = " "}
      it {should_not be_valid}
    end
    
    describe "When too long" do
      before {@user.email = "a"*255 + "@gmail.com"}
      it {should_not be_valid}
    end
  
    describe "when format is invalid" do
      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                      foo@bar_baz.com foo@bar+baz.com user@mail.ongtf]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end

    describe "when format is valid" do
      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.co.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end
    
    describe "when not unique" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.login = @user.login + "change"
        user_with_same_email.login = @user.login + "change"
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end
  
      it { should_not be_valid }
    end
  end
  
  describe "age" do
    describe "When not present" do
      before {@user.age = " "}
      it {should_not be_valid}
    end
    
    describe "when negative" do
      before {@user.age=-5}
      it {should_not be_valid}
    end
    
    describe "when over 130" do
      before {@user.age=131}
      it {should_not be_valid}
    end
  end
  
  describe "login" do
    describe "When not present" do
      before {@user.name = " "}
      it {should_not be_valid}
    end
    
    describe "When too long" do
      before { @user.name = "a" * 51 }
      it { should_not be_valid }
    end
    
    describe "When has incorrect char" do
      it "should be invalid" do
        logins = ["use\"uoo", "zz(ehrzer", "ger'ur",  "uutùu", "utr<rt", "hurr durr"]
        logins.each do |invalid_login|
          @user.login = invalid_login
          expect(@user).not_to be_valid
        end
      end
    end
    
    describe "when not unique" do
      before do
        user_with_same_login = @user.dup
        user_with_same_login.email = "change" + @user.email 
        user_with_same_login.login = @user.login.upcase
        result = user_with_same_login.save
        Rails.logger.debug "Anchor " + result.to_s
        Rails.logger.debug user_with_same_login.inspect
      end
  
      it { should_not be_valid, "User: #{@user.login}" }
    end
  end
  
  describe "password" do
    describe "when not present" do
      before { @user = User.new(
        name:   "Alfred",
        surname:"Dupond",
        email:  "alfred.dupond@gmail.com",
        age: 34,
        login: "Fredo",
        password: " ", 
        password_confirmation: " "
        ) 
      }
      it { should_not be_valid }
    end
    
    describe "when does not match " do
      before { @user.password_confirmation = @user.password + "nope" }
      it {should_not be_valid}
    end
    
    describe "with a password that's too short" do
      before { @user.password = @user.password_confirmation = "a" * 5 }
      it { should be_invalid }
    end
  
    describe "return value of authenticate method" do
      before { @user.save }
      let(:found_user) { User.find_by_email(@user.email) }
  
      describe "with valid password" do
        it { should eq found_user.authenticate(@user.password) }
      end
  
      describe "with invalid password" do
        let(:user_for_invalid_password) { found_user.authenticate("invalid") }
  
        it { should_not eq user_for_invalid_password }
        specify { expect(user_for_invalid_password).to be_false }
      end
    end
  end
end
