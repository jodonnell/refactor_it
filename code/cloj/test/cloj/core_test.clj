(ns cloj.core-test
  (:use clojure.test
        cloj.core))

(deftest query-string-parser
  (testing "can get a single pair of arguments"
    (is (= {"baby" "boomba"} (query-hash "http://www.example.com?baby=boomba"))))

  (testing "can get a multiple arguments"
    (is (= {"baby" "boomba", "cookie" "sugar"} (query-hash "http://www.example.com?baby=boomba&cookie=sugar"))))

  (testing "handle no query string"
    (is (= {} (query-hash "http://www.example.com"))))

  (testing "can handle two = signs without a seperating &"
    (is (= {"poop" "pam=pamper"} (query-hash "http://www.example.com?poop=pam=pamper"))))

  (testing "can handle no argument queries"
    (is (= {"poop" nil, "pam" "power", "ping" nil} (query-hash "http://www.example.com?poop&pam=power&ping="))))

  (testing "can turn a + into a space"
    (is (= {"value" "boom bam"} (query-hash "http://www.example.com?value=boom+bam"))))

  (testing "can decode %26"
    (is (= {"value" "boom & bam"} (query-hash "http://www.example.com?value=boom+%26+bam"))))

  (testing "can decode keys as well"
    (is (= {"boom & bam" "value"} (query-hash "http://www.example.com?boom+%26+bam=value"))))

  (testing "can turn the same keys into an array"
    (is (= {"key" ["value1", "value2", "value3"]} (query-hash "http://www.example.com?key=value1&key=value2&key=value3"))))

  (testing "can ignore an empty value"
    (is (= {"a" nil, "b" nil} (query-hash "http://www.example.com?a&&b"))))

  (testing "can ignore empty keys"
    (is (= {"pow" nil} (query-hash "http://www.example.com?pow&=pow2")))))
