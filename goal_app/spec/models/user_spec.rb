require 'rails_helper'

RSpec.describe User, type: :model do 

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  describe "uniqueness" do

    before :each do
      create :user
    end

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end

  it { should validate_length_of(:password).is_at_least(6) }

  describe "User#is_password?" do
    let(:user) { create :user }

    context "with a valid password" do 
      it "should return true" do
        expect(user.is_password?("starwars")).to be true
      end
    end

    context "with an invalid password" do 
      it "should return false" do
        expect(user.is_password?("starwars1")).to be false
      end
    end

  end

  describe "User::find_by_credentials" do
    let(:user) { create :user }

    context "with valid credentials" do
      it "should return a user" do
        expect(user.class.find_by_credentials("Andy", "starwars")).to eq(user)
      end
    end

    context "with invalid credentials" do
      it "should return nil" do
        expect(user.class.find_by_credentials("anything", "any_other_thing")).to be_nil
      end
    end
  end

  describe "User#reset-session_token!" do
    let(:user) { create :user }

    it "should reassign the session token" do
      session_token_f = user.session_token
      expect(user.reset_session_token!).to_not eq(session_token_f)
    end

  end

end