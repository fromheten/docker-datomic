(require
 '[datomic.api :as d]
 '[clojure.string :as str]
 '[clojure.set :as set])

;; Source: https://stackoverflow.com/a/12068946
(defn retry
  "Retries the given function call until no exceptions are thrown."
  [retries f & args]
  (let [res (try {:value (apply f args)}
                 (catch Exception e
                   (if (zero? retries)
                     (throw e)
                     {:exception e})))]
    (if (:exception res)
      (recur (dec retries)f args)
      (:value res))))

(let [uri      "datomic:dev://localhost:4334/"
      db-names (-> (System/getenv "DATABASES")
                   (str)
                   (str/split #"\,")
                   (as-> names (remove str/blank? names))
                   (set))]
  ;; Datomic may not yet have fully started at this point, so we must retry a couple of times.
  ;; We fetch database names to ensure datomic is available, not because it's actually useful to do so.
  (retry 5 d/get-database-names "datomic:dev://localhost:4334/*?password=123")
  (run! (fn [name] (d/create-database (str uri name "?password=123")))
        db-names)
  (when-let [dbs (seq (set/difference db-names (-> (str uri "*?password=123") d/get-database-names set)))]
    (throw (ex-info "Unable to create some databases" {:databases dbs}))))
