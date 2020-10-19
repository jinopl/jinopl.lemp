FROM bitnami/minideb:stretch
LABEL Author="Jino PL"

RUN install_packages nginx mysql-server php-fpm php-mysql

EXPOSE 80
COPY scripts/php-config.conf /etc/nginx/conf.d/php-config.conf
COPY scripts/init.sh /init.sh
RUN chmod +x /init.sh
ENTRYPOINT [ "/init.sh" ]
