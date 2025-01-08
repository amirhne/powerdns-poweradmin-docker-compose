FROM php:8.2-apache

# Install required PHP extensions and dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev openssl \
    && docker-php-ext-install mysqli pdo pdo_mysql gettext intl \
    && docker-php-ext-enable intl
# Enable Apache rewrite module
RUN a2enmod rewrite

# Enable SSL
RUN a2enmod ssl && a2enmod socache_shmcb

# Set working directory
WORKDIR /var/www/html

# Create folder for SSL Certificate
RUN mkdir /etc/ssl/poweradmin

# Set permissions for web server
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Expose port 80
EXPOSE 80
EXPOSE 443
