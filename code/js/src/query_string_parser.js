function QueryStringParser(url) {
    this.url = url;
    a = url.indexOf('?');
    if (a != -1) {
        q_str = url.substring(a+1, url.length);
        q_array = q_str.split('&')
        this.hash = {};
        debugger
        for (i = 0; i < q_array.length; i++) {
            part = q_array[i];
            parts = this.splitQueryStringEqual(part);
            if (parts[1] == undefined)
                parts[1] = null;

            if (parts[0] == null || parts[0] == '')
                continue;
            if (parts[0] in this.hash) {
                if (this.hash[parts[0]] instanceof Array)
                    this.hash[parts[0]].push(parts[1]);
                else
                    this.hash[parts[0]] = [this.hash[parts[0]], parts[1]]
            }
            else {
                this.hash[parts[0]] = parts[1];
            }
        }
    }
    else
        this.hash = {};
}

QueryStringParser.prototype.queryHash = function() {
    results = {}
    for (key in this.hash) {
        value = this.hash[key];
        if (value instanceof Array) {
            results[key] = value;
        }
        else if (value) {
            results[key] = value.replace(/\+/g, ' ');
            results[key] = results[key].replace(/%26/g, '&');

            if (key.indexOf('+') != -1 || key.indexOf('%26') != -1) {
                results[key.replace(/\+/g, ' ').replace(/%26/g, '&')] = results[key]
                delete results[key];
            }
        }
        else
            results[key] = value;
    }

    return results;
};

QueryStringParser.prototype.splitQueryStringEqual = function(part) {
    index = part.indexOf('=')
    if (index == -1)
        return [part];
    
    key = part.substring(0, index);
    value = part.substring(index + 1, part.length);
    return [key, value];
};
