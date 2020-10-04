#
# Author            Frank,H.L.Lai <frank@leadstec.com>
# Docker Version    19.03
# Website           https://www.leadstec.com
# Copyright         (C) 2020 LEADSTEC Systems. All rights reserved.
#
ARG arch=
FROM leadstec.tencentcloudcr.com/leadstec/php${arch}:7.3.22
ARG version=5.5.1
ARG build=dev

LABEL version="${version}-${build}" \
	description="Wordpress image for VCubi platform" \
	maintainer="Frank,H.L.Lai <frank@leadstec.com>"

ENV WORDPRESS_VERSION="${version}" \
	WP_CLI_VERSION="2.4.0"

# download and install wordpress
RUN curl -LfsS https://package-1253314665.cos.ap-guangzhou.myqcloud.com/noarch/wordpress/wordpress-${version}.tar.gz | tar xz --strip 1 -C ${APP_DIR} && \
	curl -LfsS https://package-1253314665.cos.ap-guangzhou.myqcloud.com/noarch/wordpress/wp-cli-${WP_CLI_VERSION}.phar -o /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

# copy install/start scripts
COPY scripts /scripts
RUN bash /scripts/setup/install
RUN rm -fr /scripts/setup
