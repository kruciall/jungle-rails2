require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'register a new user if all the inputs are valid - password and password_confirmation match' do
      user = User.new(first_name: "Vinson", last_name: "Wong", email: "vinson@gmail.com", password: "password", password_confirmation: "password")
      expect(user.save).to be true
    end

    it 'should not allow user to register without a user first_name' do
      user = User.create(last_name: "Wong", email: "vinson@gmail.com", password: "password", password_confirmation: "password")
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'should not allow user to register without a user last_name' do
      user = User.create(first_name: "Vinson", email: "vinson@gmail.com", password: "password", password_confirmation: "password")
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'should not allow user to register without a user email' do
      user = User.create(first_name: "Vinson", last_name: "Wong", password: "password", password_confirmation: "password")
      expect(user.errors.full_messages).to include("Email can't be blank")
    end
    
    it 'should not allow user to register without a password' do
      user = User.create(first_name: "Vinson", last_name: "Wong", email: "vinson@gmail.com", password_confirmation: "password")
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
    
    it 'should not allow user to register without a password_confirmation' do
      user = User.create(first_name: "Vinson", last_name: "Wong", email: "vinson@gmail.com", password: "password",)
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    
    it 'should not allow user to register with an existing email' do
      User.create!(first_name: "Vinson", last_name: "Wong", email: "vinson@gmail.com", password: "password", password_confirmation: "password")
      user = User.create(first_name: "Carol", last_name: "Smith", email: "vinson@gmail.com", password: "password", password_confirmation: "password")
      expect(user.errors.full_messages).to include("Email has already been taken")
    end
    
    it 'should not allow user to register when password and password_confirmation dont match' do
      user = User.create(first_name: "Carol", last_name: "Smith", email: "vinson@gmail.com", password: "ppppppppppp", password_confirmation: "password")
      expect(user.errors.full_messages[0]).to eql ("Password confirmation doesn't match Password")
    end
    
    it 'should not allow user to register when password and password_confirmation are less than 8 characters' do
      user = User.create(first_name: "Carol", last_name: "Smith", email: "vinson@gmail.com", password: "ppppp", password_confirmation: "ppppp")
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  # authenticatation with credentials

  describe '.authenticate_with_credentials' do

    before(:each) do
      @account = User.create!(first_name: "Vinson", last_name: "Wong", email: "vinson@gmail.com", password: "password", password_confirmation: "password")
    end

    it 'should return instance of user if successfully logged in' do
      expect(User.authenticate_with_credentials('vinson@gmail.com', 'password')).to eql @account
      
    end
    
    it 'should return nil if user is not successfully logged in' do
      user = User.authenticate_with_credentials('vinson@gmail.com', 'sword')
      expect(user).to be_nil
    end
    
    it 'should return nil if email is not successfully found' do
      user = User.authenticate_with_credentials('visssdsnson@gmail.com', 'password')
      expect(user).to be_nil
    end

    it 'should still authenticate even if email field has space in front or end' do
      user = User.authenticate_with_credentials('  vinson@gmail.com  ', 'password')
      expect(user).to eq @account
    end
    
    it 'should still authenticate even if email has CAPITALS' do
      user = User.authenticate_with_credentials('VINson@gmaIL.com', 'password')
      expect(user).to eq @account
    end

  end
end
