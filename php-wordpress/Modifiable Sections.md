# Modifiable Sections in Dockerfile for PHP WordPress Application

This document outlines the sections of the Dockerfile that can be customized to suit different project requirements, along with explanations for each part.

---

## 1. Base Build Image - `FROM php:8.1-apache AS build`

- **Description**: This line specifies the base image used for the build stage, which includes PHP 8.1 with Apache.
- **Modifiable Part**: You can change the PHP version or switch to a different base image if needed.
- **Example Modification**: To use PHP version 8.0, modify it to `FROM php:8.0-apache AS build`.

---

## 2. Working Directory - `WORKDIR /var/www/html`

- **Description**: Sets the working directory inside the container where the WordPress files will be located.
- **Modifiable Part**: Change `/var/www/html` to a different path if you prefer to organize your files differently.
- **Example Modification**: If you want to use `/usr/src/app`, modify it to `WORKDIR /usr/src/app`.

---

## 3. Installing Dependencies - `RUN apt-get update && apt-get install -y \ ...`

- **Description**: This command installs the required system libraries and PHP extensions for WordPress.
- **Modifiable Part**: You can add or remove dependencies based on your specific requirements or remove unnecessary packages.
- **Example Modification**: If you don't need GD support, remove `libpng-dev \`, `libjpeg-dev \`, and `docker-php-ext-install gd`.

---

## 4. Downloading WordPress - `RUN curl -o wordpress.tar.gz https://wordpress.org/latest.tar.gz && \ ...`

- **Description**: Downloads the latest version of WordPress and extracts it to the working directory.
- **Modifiable Part**: You can specify a different version of WordPress by changing the URL.
- **Example Modification**: To download WordPress version 6.0, change it to `RUN curl -o wordpress.tar.gz https://wordpress.org/wordpress-6.0.tar.gz`.

---

## 5. Copying Configuration File - `COPY wp-config.php .`

- **Description**: This line copies a custom `wp-config.php` file from the host machine into the working directory inside the container.
- **Modifiable Part**: Change the file path if your configuration file has a different name or location.
- **Example Modification**: If your configuration file is named `my-wp-config.php`, modify it to `COPY my-wp-config.php .`.

---

## 6. Base Production Image - `FROM php:8.1-apache`

- **Description**: Starts a new stage with a fresh PHP 8.1 and Apache image for the production environment.
- **Modifiable Part**: You can change the base image to a different version or a different PHP runtime if needed.
- **Example Modification**: To use PHP 7.4, modify it to `FROM php:7.4-apache`.

---

## 7. Copying Built Files - `COPY --from=build /var/www/html /var/www/html`

- **Description**: This line copies the WordPress files from the previous build stage into the final image.
- **Modifiable Part**: If you change the output directory in the build stage, adjust this path accordingly.
- **Example Modification**: If your files are in a different directory, change it to match that path, e.g., `COPY --from=build /usr/src/app /var/www/html`.

---

## 8. Setting Permissions - `RUN chown -R www-data:www-data /var/www/html`

- **Description**: This command sets the ownership of the WordPress files to `www-data`, ensuring proper access for the web server.
- **Modifiable Part**: You can change the user and group if your web server uses different settings.
- **Example Modification**: To set it to a different user, modify it to `RUN chown -R myuser:mygroup /var/www/html`.

---

## 9. Exposing a Port - `EXPOSE 80`

- **Description**: This line informs Docker that the container listens on port 80 at runtime, which is the standard HTTP port.
- **Modifiable Part**: Change this port if your application is set to use a different one.
- **Example Modification**: If you want to use port 8080, modify it to `EXPOSE 8080`.

---

## 10. Default Command - `CMD ["apache2-foreground"]`

- **Description**: Sets the default command to run when the container starts, which starts the Apache web server in the foreground.
- **Modifiable Part**: You can modify this command to include additional options or settings if necessary.
- **Example Modification**: To include a custom configuration file, change it to `CMD ["apache2-foreground", "-c", "/etc/apache2/sites-enabled/000-default.conf"]`.
