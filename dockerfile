# Stage 1: Build stage with a specific PHP version
FROM php:8.1-fpm AS build  # You can change the version here to any PHP version you need

# Setting the main working directory
WORKDIR /var/www  # Adjust this path if you want a different location for running the application

# Installing system libraries and PHP extensions required for Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Installing Composer from an official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copying application files
COPY . .

# Installing dependencies via Composer, excluding development dependencies to reduce image size
RUN composer install --no-dev --optimize-autoloader

# Important Laravel commands to optimize caching
RUN php artisan config:cache && php artisan route:cache  # You can add or remove any Laravel commands like migration if needed

# Stage 2: Preparing the final production image
FROM php:8.1-fpm  # Adjust this version if you need a different one

# Copying the application files we prepared from the build stage
COPY --from=build /var/www /var/www

# Main working directory
WORKDIR /var/www  # You can change this if you want a different path for the final runtime

# Setting up permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage  # If there are other directories needing different permissions, you can add them here

# Exposing port 9000 to run PHP-FPM
EXPOSE 9000  # You can change the port if a different one fits your environment

# Final runtime command
CMD ["php-fpm"]  # Add any extra settings here if you have specific requirements
