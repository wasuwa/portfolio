require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {
    User.new(
      name: "example",
      email: "example@gmail.com"
    )
  }
  let(:no_name) {
    User.new(
      name: "",
      email: "no_name@gmail.com"
    )
  }

  context "Name and email address exist" do
    it 'valid' do
      user.valid?
      expect(user).to be_valid
    end
    it 'no names' do
      no_name.valid?
      expect(no_name.errors[:name]).to include("can't be blank")
    end
  end

  # it "is invalid without email" do

  # end
  # it "is invalid if email is duplicated" do
    
  # end
  # describe "word count" do
  #   context "valid" do
  #     it "is valid when name is 8 characters" do
    
  #     end
  #     it "is valid when email is 255 characters" do
    
  #     end
  #   end
  #   context "invalid" do
  #     it "is invalid when name is 9 characters" do
    
  #     end
  #     it "is invalid when email is 256 characters" do
    
  #     end
  #   end
  # end
end