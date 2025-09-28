#!/bin/bash
set -e

if [ ! -e '/var/www/html/index.php' ]; then
	cd /var/www/html
	tar cf - --one-file-system -C /usr/src/tastyigniter . | tar xf -
	chown -R www-data:www-data /var/www/html
	if [ ! -f ".env" ] && [ -f ".env.example" ]; then
		cp .env.example .env
	fi
	php artisan key:generate --force
	php artisan igniter:install --no-interaction

fi

exec "$@"
