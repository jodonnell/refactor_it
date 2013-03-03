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
    expect(QueryStringParser.new('http://www.example.com?poop=pam=pamper').queryHash).to eq({poop: 'pam=pamper'})
  end

  it "can handle no argument queries" do
    expect(QueryStringParser.new('http://www.example.com?poop&pam=power&ping').queryHash).to eq({poop: nil, pam: "power", ping: nil})
  end

  it "can turn a + into a space" do
    expect(QueryStringParser.new('http://www.example.com?value=boom+bam').queryHash).to eq({value: 'boom bam'})
  end

  it "can decode %26" do
    expect(QueryStringParser.new('http://www.example.com?value=boom+%26+bam').queryHash).to eq({value: 'boom & bam'})
  end



end
