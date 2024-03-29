GIT_COMMIT = $(strip $(shell git rev-parse --short HEAD))

DOCKER_IMAGE ?= mateumann/privoxy
DOCKER_TAG = latest
PRIVOXY_VERSION = $(strip $(shell grep 'apk add.*privoxy' Dockerfile | sed -r "s/.*apk\ add.*privoxy=([0-9.]+).*/\\1/"))

# Build Docker image
build: docker_build output

# Build and push Docker image
release: docker_build docker_push output

default: docker_build_squash output

docker_build_squash:
	DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=$(GIT_COMMIT) \
		--build-arg PRIVOXY_VERSION=$(PRIVOXY_VERSION) \
		--squash \
		-t $(DOCKER_IMAGE):$(GIT_COMMIT) .
	docker tag $(DOCKER_IMAGE):$(GIT_COMMIT) $(DOCKER_IMAGE):$(PRIVOXY_VERSION)-r2
	docker tag $(DOCKER_IMAGE):$(GIT_COMMIT) $(DOCKER_IMAGE):$(DOCKER_TAG)

docker_build:
	DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VCS_REF=$(GIT_COMMIT) \
		--build-arg PRIVOXY_VERSION=$(PRIVOXY_VERSION) \
		-t $(DOCKER_IMAGE):$(GIT_COMMIT) .
	docker tag $(DOCKER_IMAGE):$(GIT_COMMIT) $(DOCKER_IMAGE):$(PRIVOXY_VERSION)-r2
	docker tag $(DOCKER_IMAGE):$(GIT_COMMIT) $(DOCKER_IMAGE):$(DOCKER_TAG)

docker_push:
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
	docker push $(DOCKER_IMAGE):$(PRIVOXY_VERSION)-r2

output:
	@echo Docker Image: $(DOCKER_IMAGE):$(PRIVOXY_VERSION)

