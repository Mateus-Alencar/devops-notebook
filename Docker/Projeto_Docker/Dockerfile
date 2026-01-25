FROM php:8-apache

WORKDIR /var/www/html

COPY . .

# Criar pasta de mensagens + permissões
RUN mkdir -p /var/www/html/messages \
    && chown -R www-data:www-data /var/www/html \
    && chmod 775 /var/www/html/messages

EXPOSE 80