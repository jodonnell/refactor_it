class QueryStringParser:
    def __init__(self, url):
        self.url = url
        a = url.find('?')
        if a != -1:
            q_str = url[a+1:len(url)]
            q_array = q_str.split('&')
            self.hash = {}
            for part in q_array:
                parts = part.split('=', 1)
                if parts[0] == None or parts[0] == '':
                    continue
                if parts[0] in self.hash:
                    if type(self.hash[parts[0]]) is list:
                        self.hash[parts[0]].append(parts[1])
                    else:
                        self.hash[parts[0]] = [self.hash[parts[0]], parts[1]]
                else:
                    if len(parts) == 1:
                        self.hash[parts[0]] = None
                    else:
                        self.hash[parts[0]] = parts[1]
        else:
            self.hash = {}

    def query_hash(self):
        results = {}
        for key, value in self.hash.iteritems():
            if type(value) is list:
                results[key] = value
            elif value:
                results[key] = value.replace('+', ' ')
                results[key] = results[key].replace('%26', '&')

                if key.find('+') != -1 or key.find('%26') != -1:
                    results[key.replace('+', ' ').replace('%26', '&')] = results[key]
                    del results[key]
            else:
                results[key] = value
        return results
