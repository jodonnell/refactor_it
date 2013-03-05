import unittest
from query_string_parser import QueryStringParser

class TestQueryStringParser(unittest.TestCase):

    def test_gets_a_single_pair_of_arguments(self):
        self.assertEqual(QueryStringParser('http://www.example.com?baby=boomba').query_hash(), {'baby': 'boomba'})

    def test_gets_multiple_arguments(self):
        self.assertEqual(QueryStringParser('http://www.example.com?baby=boomba&cookie=sugar').query_hash(), {'baby': 'boomba', 'cookie': 'sugar'})

    def test_handles_no_query_string(self):
        self.assertEqual(QueryStringParser('http://www.example.com').query_hash(), {})

    def test_handles_an_equal_sign_in_value(self):
        self.assertEqual(QueryStringParser('http://www.example.com?poop=pam=pamper').query_hash(), {'poop': 'pam=pamper'})

    def test_handles_no_argument_query_strings(self):
        self.assertEqual(QueryStringParser('http://www.example.com?poop&pam=power&ping=').query_hash(), {'poop': None, 'pam': "power", 'ping': ""})

    def test_decodes_plus_to_space(self):
        self.assertEqual(QueryStringParser('http://www.example.com?value=boom+bam').query_hash(), {'value': 'boom bam'})

    def test_decodes_ampersand(self):
        self.assertEqual(QueryStringParser('http://www.example.com?value=boom+%26+bam').query_hash(), {'value': 'boom & bam'})

    def test_can_decode_keys(self):
        self.assertEqual(QueryStringParser('http://www.example.com?boom+%26+bam=value').query_hash(), {'boom & bam': 'value'})

    def test_can_turn_the_same_keys_into_array(self):
        self.assertEqual(QueryStringParser('http://www.example.com?key=value1&key=value2&key=value3').query_hash(), {'key': ['value1', 'value2', 'value3']})

    def test_can_ignore_empty_values(self):
        self.assertEqual(QueryStringParser('http://www.example.com?a&&b').query_hash(), {'a': None, 'b': None})

    def test_can_ignore_empty_keys(self):
        self.assertEqual(QueryStringParser('http://www.example.com?pow&=pow2').query_hash(), {'pow': None})

if __name__ == '__main__':
    unittest.main()
