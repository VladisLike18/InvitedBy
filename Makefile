down: docker-down
up: docker-up
init: docker-down-clear docker-pull docker-build docker-up run-app
exec_php: docker-exec-php-bash
exec_node: docker-exec-node-bash
test: invited-test

docker-exec-php-bash:
	docker exec -it invited_php-fpm bash

docker-exec-node-bash:
	docker exec -it invited_node sh

invited-test:
	docker exec -it invited_php-fpm php bin/phpunit

docker-up:
	docker-compose -f docker_invited/docker-compose.yml up -d

docker-down:
	docker-compose -f docker_invited/docker-compose.yml down --remove-orphans

docker-down-clear:
	docker-compose -f docker_invited/docker-compose.yml down -v --remove-orphans

docker-pull:
	docker-compose -f docker_invited/docker-compose.yml pull

docker-build:
	docker-compose -f docker_invited/docker-compose.yml build

#Run app
run-app: composer-install

composer-install:
	docker exec -it invited_php-fpm composer install
