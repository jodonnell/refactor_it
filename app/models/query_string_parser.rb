class QueryStringParser
  def initialize url
    @url = url
    a = url.index('?')
    if a
      q_str = url[a+1..url.length]
      q_array = q_str.split('&')
      @hash = {}
      q_array.each {|part| parts = part.split('='); @hash[parts[0].to_sym] = parts[1]}
    else
      @hash = {}
    end
  end

  def queryHash
    @hash
  end
end
