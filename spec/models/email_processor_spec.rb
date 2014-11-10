require 'rails_helper'

describe EmailProcessor do
  before do
    @email = build(:email)
  end

  it "receives an incoming email" do
    processor = EmailProcessor.new(@email)
    received_email = processor.email
    expect(assign(:email)).to eq(@email)
  end

  it "can access email attributes" do
    processor = EmailProcessor.new(@email)
    received_email = processor.email
    expect( received_email.from ).to eq(@email[:from])
    expect( received_email.to ).to eq(@email[:to])
    expect( received_email.subject ).to eq(@email[:subject])
  end

  it "saves the url" do
    expect {
      EmailProcessor.new(@email).process
    }.to change(Bookmark, :count).by(1)
  end

  it "does not bookmark the url if user is not signed in" do
    expect {
      EmailProcessor.new(@email).process
    }.to change(Bookmark, :count).by(0)
  end

end
