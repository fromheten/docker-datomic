DOCKER_IMAGE=datomic
DOCKER_TAG?=$(shell ./datomic-version)

.PHONY: all clean info

all: Dockerfile
	docker build \
	--build-arg DATOMIC_REPO_USER=${DATOMIC_REPO_USER} \
	--build-arg DATOMIC_REPO_PASS=${DATOMIC_REPO_PASS} \
	--build-arg DATOMIC_LICENSE=${DATOMIC_LICENSE} \
	-t $(DOCKER_IMAGE):$(DOCKER_TAG) .

clean:
	docker rmi $(DOCKER_IMAGE):$(DOCKER_TAG)

info:
	@echo "Docker image: $(DOCKER_IMAGE):$(DOCKER_TAG)"
