(ns cloj.core)

(defn query-part [url]
  (clojure.string/split url #"\?" 2))

(defn get-parts [url]
  (clojure.string/split (last (query-part url)) #"&"))

(defn replace-plus [part]
  (clojure.string/replace part #"\+" " "))

(defn replace-ampersand [part]
  (clojure.string/replace part #"%26" "&"))

(defn split-on-equal [part]
  (if (= 1 (count (clojure.string/split part #"=" 2)))
    (conj (vector (replace-ampersand (replace-plus (first (clojure.string/split part #"="))))) nil)
    (mapv replace-ampersand (mapv replace-plus (clojure.string/split part #"=" 2)))))

(defn query-hash [url]
  (if (= 2 (count (query-part url)))
    (into {} (map split-on-equal (get-parts url)))
    {}))


