# Summary of Modifiable Sections

- **PHP Version** - Any instance of `php:8.1-fpm`.
- **Main Directory (WORKDIR)** - `WORKDIR /var/www`.
- **System Libraries and PHP Extensions** - Commands under `RUN apt-get install -y`.
- **Laravel Commands** - Any `php artisan` commands.
- **Permissions** - `RUN chown -R ... && chmod -R ...`.
- **Port (Port)** - `EXPOSE 9000`.
- **Final Runtime Command (CMD)** - `CMD ["php-fpm"]`.

Each section is modifiable to suit your application’s requirements and runtime environment.
