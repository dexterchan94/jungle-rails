require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    
    it "is valid with valid fields" do
      @user = User.create(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it "is not valid without a name" do
      @user = User.create(email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it "is not valid without an email" do
      @user = User.create(name: "John Smith", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it "is not valid if the password_confirmation does not match" do
      @user = User.create(name:"John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "potato")
      expect(@user).to_not be_valid
    end

    it "is not valid if the email always belongs to another user" do
      @user1 = User.create(name:"John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user2 = User.create(name:"John Smith", email: "JOHNSMITH@GMAIL.COM", password: "password", password_confirmation: "password")
      expect(@user2).to_not be_valid
    end

    it "is not valid if the password length is less than 6 characters long" do
      @user = User.create(name:"John Smith", email: "johnsmith@gmail.com", password: "123", password_confirmation: "123")
      expect(@user).to_not be_valid
    end

  end


  describe '.authenticate_with_credentials' do

    it 'returns a user with valid credentials' do
      User.create(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user = User.authenticate_with_credentials("johnsmith@gmail.com", "password")
      expect(@user).to be_an_instance_of(User)
    end

    it 'returns nil for invalid credentials' do
      User.create(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user = User.authenticate_with_credentials("johnsmith@gmail.com", "potato")
      expect(@user).to be_nil
    end

    it 'returns a user with trailing whitespace in the email field' do
      User.create(name: "John Smith", email: "johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user = User.authenticate_with_credentials(" johnsmith@gmail.com ", "password")
      expect(@user).to be_an_instance_of(User)
    end

    it 'returns a user with any combination of upper/lowercase characters for a valid email' do
      User.create(name: "John Smith", email: "Johnsmith@gmail.com", password: "password", password_confirmation: "password")
      @user = User.authenticate_with_credentials("jOhNsMiTh@gMaIl.CoM ", "password")
      expect(@user).to be_an_instance_of(User)
    end

  end

end
