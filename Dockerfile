FROM clojure:lein-2.6.1-alpine

# 1. Make sure to add these arguments to docker
# when building the container
ARG DATOMIC_REPO_USER
ARG DATOMIC_REPO_PASS
ARG DATOMIC_LICENSE

ENV DATOMIC_VERSION 0.9.5561
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

VOLUME $DATOMIC_DATA

EXPOSE 4334 4335 4336

# 2. To start datomic execute the following command in the container:
# ./bin/transactor <path_to_transactor.properties>