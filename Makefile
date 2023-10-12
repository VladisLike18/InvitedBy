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

#invited-migrate
#invited-fixture
run-app: composer-install invited-phpcs

composer-install:
	docker exec -it invited_php-fpm composer install

#invited-migrate:
#docker exec -it invited_php-fpm php bin/console doctrine:migrations:migrate --no-interaction

#invited-fixture:
#docker exec -it invited_php-fpm php bin/console doctrine:fixtures:load --no-interaction

invited-phpcs: invited-phpcs-mkdir invited-phpcs-composer
invited-phpcs-mkdir:
	docker exec -it invited_php-fpm mkdir -p --parents tools/php-cs-fixer
invited-phpcs-composer:
	docker exec -it invited_php-fpm composer require --no-interaction --working-dir=tools/php-cs-fixer friendsofphp/php-cs-fixer

fixer:
	docker exec -it invited_php-fpm tools/php-cs-fixer/vendor/bin/php-cs-fixer fix src