FROM clojure:lein-2.9.1-alpine

ARG DATOMIC_REPO_USER
ARG DATOMIC_REPO_PASS
ARG DATOMIC_LICENSE

ENV DATOMIC_VERSION 1.0.6202.0
ENV DATOMIC_HOME /opt/datomic-pro-$DATOMIC_VERSION
ENV DATOMIC_DATA $DATOMIC_HOME/data

RUN apk add --no-cache unzip curl gettext

RUN curl -u ${DATOMIC_REPO_USER}:${DATOMIC_REPO_PASS} -SL https://my.datomic.com/repo/com/datomic/datomic-pro/$DATOMIC_VERSION/datomic-pro-$DATOMIC_VERSION.zip -o /tmp/datomic.zip \
  && unzip /tmp/datomic.zip -d /opt \
  && rm -f /tmp/datomic.zip

WORKDIR $DATOMIC_HOME
RUN echo DATOMIC HOME: $DATOMIC_HOME

COPY transactor.properties transactor-tmp.properties
RUN envsubst < transactor-tmp.properties > transactor.properties

COPY entrypoint.sh entrypoint.sh
COPY create-dbs.clj create-dbs.clj

HEALTHCHECK --start-period=5s CMD curl -k http://localhost:9999/health

VOLUME $DATOMIC_DATA

EXPOSE 4334 4335 4336

CMD ["./bin/transactor", "./transactor.properties"]
ENTRYPOINT [ "./entrypoint.sh" ]
