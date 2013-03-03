class QueryStringParser
  def initialize url
    @url = url
    a = url.index('?')
    if a
      q_str = url[a+1..url.length]
      q_array = q_str.split('&')
      @hash = {}
      q_array.each {|part| parts = part.split('=', 2); @hash[parts[0]] = parts[1]}
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

        if key.index '+' or key.index '%26'
          results[key.gsub('+', ' ').gsub('%26', '&')] = results[key]
          results.delete key
        end
      else
        results[key] = value
      end
    end
    results
  end
end
