require 'spec_helper'

describe Speaker do
  it "should create valid model" do
    speaker = Speaker.new
    speaker.user = Factory(:user)
    speaker.discussion = Factory(:discussion)
    speaker.save.should be true
  end
  
  it "should bot create model without discussion" do
    speaker = Speaker.new
    speaker.user = Factory(:user)
    speaker.save.should be false
  end
end
