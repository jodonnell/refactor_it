class QueryStringParser
  def initialize url
    @url = url
    a = url.index('?')
    if a
      q_str = url[a+1..url.length]
      q_array = q_str.split('&')
      @hash = {}
      q_array.each {|part| parts = part.split('=', 2); @hash[parts[0].to_sym] = parts[1]}
    else
      @hash = {}
    end
  end

  def queryHash
    results = {}
    @hash.each do |key, value| 
      if value
        results[key] = value.gsub('+', ' ')
        results[key] = results[key].gsub('%26', '&')
      else
        results[key] = value
      end
    end
    results
  end
end
