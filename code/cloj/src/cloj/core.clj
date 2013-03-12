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


(defn drop-empty-key [things]
  (filter #(not= "" (first %)) things))


(defn merge-lists [& maps]
  (reduce (fn [m1 m2]
            (reduce (fn [m [k v]]
                      (update-in m [k] (fnil conj []) v))
                    m1, m2))
          {}
          maps))

(defn get-hash [url]
  (merge-lists (drop-empty-key (map split-on-equal (get-parts url)))))

(defn query-hash [url]
  (if (= 2 (count (query-part url)))
    (zipmap (keys (get-hash url)) (map #(if (= 1 (count %)) (first %) %  ) (vals (get-hash url))))
    {}))


