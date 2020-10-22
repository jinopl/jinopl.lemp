FROM bitnami/minideb:stretch
LABEL Author="Jino PL"

RUN install_packages nginx mysql-server php-fpm php-mysql curl ca-certificates

EXPOSE 80
COPY scripts/local_site /etc/nginx/sites-available/local_site
COPY scripts/init.sh /init.sh
RUN chmod +x /init.sh
ENTRYPOINT [ "/init.sh" ]
