CONTAINER_NAME=netwatch
IMAGE_TAG=sinclairstudios/${CONTAINER_NAME}
CONTAINERS_TO_REMOVE=$(shell docker ps -a -q -f "name=${CONTAINER_NAME}" | wc -l | xargs)

PORTS=-p 3000:3000

.PHONY: build
build:
	@docker build -t ${IMAGE_TAG} .

.PHONY: debug
debug: rm
	@docker run ${PORTS} --name ${CONTAINER_NAME} -i -t ${IMAGE_TAG} bash

.PHONY: run
run: rm
	@docker run ${PORTS} --name ${CONTAINER_NAME} -d ${IMAGE_TAG}

.PHONY: rm
rm:
ifneq ($(CONTAINERS_TO_REMOVE),0)
	@docker rm -f `docker ps -a -q -f "name=${CONTAINER_NAME}"`
endif

