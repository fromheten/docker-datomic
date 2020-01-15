(require
 '[datomic.api :as d]
 '[clojure.string :as str]
 '[clojure.set :as set])

(let [uri      "datomic:dev://localhost:4334/"
      db-names (-> (System/getenv "DATABASES")
                   (str)
                   (str/split #"\,")
                   (as-> names (remove str/blank? names))
                   (set))]
  (run! (fn [name] (d/create-database (str uri name "?password=123")))
        db-names)
  (when-let [dbs (seq (set/difference db-names (-> (str uri "*?password=123") d/get-database-names set)))]
    (throw (ex-info "Unable to create some databases" {:databases dbs}))))
