require "spec_helper"

describe QueryStringParser do
  it "can get a single pair of arguments" do
    expect(QueryStringParser.new('http://www.example.com?baby=boomba').query_hash).to eq({'baby' => 'boomba'})
  end

  it "can get a multiple arguments" do
    expect(QueryStringParser.new('http://www.example.com?baby=boomba&cookie=sugar').query_hash).to eq({'baby' => 'boomba', 'cookie' => 'sugar'})
  end

  it "handle no query string" do
    expect(QueryStringParser.new('http://www.example.com').query_hash).to eq({})
  end

  it "can handle two = signs without a seperating &" do
    expect(QueryStringParser.new('http://www.example.com?poop=pam=pamper').query_hash).to eq({'poop' => 'pam=pamper'})
  end

  it "can handle no argument queries" do
    expect(QueryStringParser.new('http://www.example.com?poop&pam=power&ping=').query_hash).to eq({'poop' => nil, 'pam' => "power", 'ping' => ""})
  end

  it "can turn a + into a space" do
    expect(QueryStringParser.new('http://www.example.com?value=boom+bam').query_hash).to eq({'value' => 'boom bam'})
  end

  it "can decode %26" do
    expect(QueryStringParser.new('http://www.example.com?value=boom+%26+bam').query_hash).to eq({'value' => 'boom & bam'})
  end

  it "can decode keys as well" do
    expect(QueryStringParser.new('http://www.example.com?boom+%26+bam=value').query_hash).to eq({'boom & bam' => 'value'})
  end

  it "can turn the same keys into an array" do
    expect(QueryStringParser.new('http://www.example.com?key=value1&key=value2&key=value3').query_hash).to eq({'key' => ['value1', 'value2', 'value3']})
  end

  it "can ignore an empty value" do
    expect(QueryStringParser.new('http://www.example.com?a&&b').query_hash).to eq({'a' => nil, 'b' => nil})
  end

  it "can ignore empty keys" do
    expect(QueryStringParser.new('http://www.example.com?pow&=pow2').query_hash).to eq({'pow' => nil})
  end

end
