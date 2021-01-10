#
# Author            Frank,H.L.Lai <frank@leadstec.com>
# Docker Version    20.10
# Website           https://www.leadstec.com
# Copyright         (C) 2021 LEADSTEC Systems. All rights reserved.
#
FROM leadstec/php:7.3.26

LABEL description="Wordpress image for VCubi platform" \
	maintainer="Frank,H.L.Lai <frank@leadstec.com>"

# download and install wordpress
RUN curl -LfsS https://wordpress.org/wordpress-5.6.tar.gz | tar xz --strip 1 -C ${APP_DIR} && \
	curl -LfsS https://github.com/wp-cli/wp-cli/releases/download/v2.4.0/wp-cli-2.4.0.phar -o /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

# copy install/start scripts
COPY scripts /scripts
RUN bash /scripts/setup/install
RUN rm -fr /scripts/setup
