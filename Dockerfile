# Adds xDebug support to Conetix's docker-wordpress-wp-cli
# Adds tcpdump support to Johnrom's docker-wordpress-wp-cli-xdebug
# Docker Hub: https://hub.docker.com/r/eceleste/docker-wordpress-wp-cli-xdebug/
# Github Repo: https://github.com/efc/docker-wordpress-wp-cli-xdebug

FROM wordpress:latest
MAINTAINER efc@clst.org

# Add sudo in order to run wp-cli as the www-data user
RUN apt-get update && apt-get install -y sudo less

# Add tcpdump to our wordpress container for debugging
RUN apt-get update &&  apt-get -y -q install tcpdump

# Add WP-CLI
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar /bin/wp

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN yes | pecl install xdebug \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_output_name=cachegrind.out.%t" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.profiler_output_dir=/tmp" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && rm -rf /usr/local/etc/php/conf.d/opcache-recommended.ini
