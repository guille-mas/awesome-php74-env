include .env

# Bake a new image
build:
	docker build -t ${PROJECT_NAME}:${IMAGE_VERSION_TAG} \
		--build-arg HTTP_PORT=${HTTP_PORT} \
		--build-arg HTTPS_PORT=${HTTPS_PORT} \
		--build-arg PROJECT_NAME=${PROJECT_NAME} \
		--build-arg APP_ROOT_DIR=${APP_ROOT_DIR} \
		--target dev-image .

# Start the development environment as it is
start:
	docker run --rm \
		-p ${HTTP_PORT}:${HTTP_PORT}/tcp \
		-p ${HTTPS_PORT}:${HTTPS_PORT}/tcp \
		-v ${PWD}/src:${APP_ROOT_DIR} \
		-v ${PWD}/data:/tmp/${PROJECT_NAME} \
		-e HTTPS_PORT=${HTTPS_PORT} \
		-e HTTP_PORT=${HTTP_PORT} \
		-e APP_ROOT_DIR=${APP_ROOT_DIR} \
		-e APP_PUBLIC_DIR=${APP_PUBLIC_DIR} \
		-e IMAGE_VERSION_TAG=${IMAGE_VERSION_TAG} \
		-e HOME=${APP_ROOT_DIR} \
		--name ${PROJECT_NAME}-container \
		${PROJECT_NAME}:${IMAGE_VERSION_TAG}

# Execute a command inside the container as user www-data 
exec:
	@read -p "Write a command to execute inside your running container: " command; \
	docker exec -it ${PROJECT_NAME}-container sh -c "$$command"

# Execute a command inside the container as user www-data 
sudo:
	@read -p "Write a command to execute inside your running container (AS ROOT): " command; \
	docker exec --user root ${PROJECT_NAME}-container sh -c "$$command"

# Stops the container
stop: 
	-docker container stop ${PROJECT_NAME}-container

# Delete the image and its container
clean: stop	
	-docker container rm ${PROJECT_NAME}-container
	docker image rm ${PROJECT_NAME}:${IMAGE_VERSION_TAG}

