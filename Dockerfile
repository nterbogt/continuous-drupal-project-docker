FROM drupal:8.9-apache

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
        git-all \
        unzip \
        fonts-liberation libdrm2 libgbm1 libnspr4 libnss3 wget xdg-utils dbus; \
    apt-get clean

# Install Chrome.
RUN curl -o google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; \
    dpkg -i ./google-chrome*.deb; \
    rm -f ./google-chrome*.deb

COPY zzz-phpunit-recommended.ini /usr/local/etc/php/conf.d/zzz-phpunit-recommended.ini

WORKDIR /opt/drupal

# Install required packages.
RUN set -eux; \
    composer require drupal/core-dev:^8.9 drush/drush;

# Set up initial Drupal installation.
RUN set -eux; \
    drush site:install standard --db-url=sqlite://sites/default/files/database.sqlite --site-name=PhpunitCI --account-name=admin --account-pass=admin; \
    chown -R www-data:www-data web/sites/default/files

COPY phpunit.xml web/core/phpunit.xml

# vim:set ft=dockerfile:
