require "spec_helper"

describe QueryStringParser do
  it "can get a single pair of arguments" do
    expect(QueryStringParser.new('http://www.example.com?baby=boomba').queryHash).to eq({baby: 'boomba'})
  end

  it "can get a multiple arguments" do
    expect(QueryStringParser.new('http://www.example.com?baby=boomba&cookie=sugar').queryHash).to eq({baby: 'boomba', cookie: 'sugar'})
  end

  it "handle no query string" do
    expect(QueryStringParser.new('http://www.example.com').queryHash).to eq({})
  end

  it "can handle two = signs without a seperating &" do
    pending
    expect(QueryStringParser.new('http://www.example.com?poop=pam=pamper').queryHash).to eq({poop: 'pam=pamper'})
  end

end
