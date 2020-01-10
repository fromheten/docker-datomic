(require
 '[datomic.api :as d]
 '[clojure.string :as str])

(doseq [name (-> (System/getenv "DATABASES")
                 (str)
                 (str/split #"\,"))]
  (when (and (not (str/blank? name))
             (d/create-database (str "datomic:dev://localhost:4334/" name)))
    (println "Created database:" name)))
