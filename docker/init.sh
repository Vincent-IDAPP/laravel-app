#!/bin/sh

echo "⏳ Attente de MySQL..."

until nc -z mysql 3306; do
  sleep 2
  echo "⏳ En attente de la BDD..."
done

echo "✅ Base de données prête. Lancement des migrations..."

php artisan migrate --force || exit 1

echo "✅ Lancement des seeders..."

php artisan db:seed --force || exit 1

echo "✅ Démarrage de PHP-FPM..."

php-fpm
