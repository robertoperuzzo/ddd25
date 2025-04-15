#!/bin/bash
# This script launches a Drupal 11 site with Typesense integration using DDEV.
mkdir drupal-typesense && cd drupal-typesense
ddev config --project-type=drupal11 --docroot=web
ddev start
ddev composer create drupal/recommended-project:^11
ddev exec sed -i 's/"minimum-stability": "stable"/"minimum-stability": "dev"/g' composer.json
ddev composer update
ddev composer require drush/drush
ddev composer require drupal/ai
ddev composer require drupal/ai_provider_openai
ddev composer require drupal/search_api_typesense
# ddev get kevinquillen/ddev-typesense
ddev get https://github.com/robertoperuzzo/ddev-typesense/tarball/5-upgrade-docker-image
ddev restart
ddev drush site:install --account-name=admin --account-pass=admin -y
ddev drush en search_api_typesense ai ai_provider_openai -y
ddev launch
