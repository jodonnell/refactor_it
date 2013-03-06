describe("QueryStringParser", function() {
    
    it("can get a single pair of arguments", function() {
        expect((new QueryStringParser('http://www.example.com?baby=boomba')).queryHash()).toEqual({'baby': 'boomba'})
    });

    it("can get a multiple arguments", function() {
        expect((new QueryStringParser('http://www.example.com?baby=boomba&cookie=sugar')).queryHash()).toEqual({'baby':  'boomba', 'cookie':  'sugar'})
    });

    it("handle no query string", function() {
        expect((new QueryStringParser('http://www.example.com')).queryHash()).toEqual({})
    });

    it("can handle two = signs without a seperating &", function() {
        expect((new QueryStringParser('http://www.example.com?poop=pam=pamper')).queryHash()).toEqual({'poop':  'pam=pamper'})
    });

    it("can handle no argument queries", function() {
        expect((new QueryStringParser('http://www.example.com?poop&pam=power&ping=')).queryHash()).toEqual({'poop':  null, 'pam':  "power", 'ping':  ""})
    });

    it("can turn a + into a space", function() {
        expect((new QueryStringParser('http://www.example.com?value=boom+bam')).queryHash()).toEqual({'value':  'boom bam'})
    });

    it("can decode %26", function() {
        expect((new QueryStringParser('http://www.example.com?value=boom+%26+bam')).queryHash()).toEqual({'value':  'boom & bam'})
    });

    it("can decode keys as well", function() {
        expect((new QueryStringParser('http://www.example.com?boom+%26+bam=value')).queryHash()).toEqual({'boom & bam':  'value'})
    });

    it("can turn the same keys into an array", function() {
        expect((new QueryStringParser('http://www.example.com?key=value1&key=value2&key=value3')).queryHash()).toEqual({'key':  ['value1', 'value2', 'value3']})
    });

    it("can ignore an empty value", function() {
        expect((new QueryStringParser('http://www.example.com?a&&b')).queryHash()).toEqual({'a':  null, 'b':  null})
    });

    it("can ignore empty keys", function() {
        expect((new QueryStringParser('http://www.example.com?pow&=pow2')).queryHash()).toEqual({'pow':  null})
    });
});
