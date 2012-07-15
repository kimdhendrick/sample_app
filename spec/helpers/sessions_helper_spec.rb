require 'spec_helper'

describe SessionsHelper do

  describe "signed_in" do
    let(:user) { FactoryGirl.create(:user) }
    
    it "should not be signed in" do
      signed_in?.should == false
    end
    
    it "should be signed in" do
      sign_in(user)
      signed_in?.should == true
    end

  end
end