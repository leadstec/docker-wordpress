#
# AUTHOR            Frank,H.L.Lai <frank@leadstec.com>
# DOCKER-VERSION    18.06
# Copyright         (C) 2018 Leads Technologies Ltd. All rights reserved.
#
ARG arch=
FROM regimg.com/php7${arch}:7.2.10

ARG version=4.9.x
ARG build=dev

LABEL version="${version}-${build}" \
	description="Wordpress docker image for VCubi" \
	maintainer="Frank,H.L.Lai <frank@leadstec.com>"

# set environment variables
ENV WORDPRESS_VERSION="${version}" \
	WP_CLI_VERSION="2.0.1" \
    WP_PLUGINS_TMP_DIR="/data/wp_plugins" \
    WP_PRIVATE_REPO="http://repo.leadstec.com/artifactory/ext-release/wordpress"

# download and install wordpress
RUN curl -fsSL ${WP_PRIVATE_REPO}/wordpress-${WORDPRESS_VERSION}-zh_CN.tar.gz | tar xz --strip 1 -C ${APP_DIR} && \
	curl ${WP_PRIVATE_REPO}/wp-cli/wp-cli-${WP_CLI_VERSION}.phar -o /usr/local/bin/wp && \
	chmod +x /usr/local/bin/wp

# copy install/start scripts
COPY scripts /scripts
RUN bash /scripts/setup/install
RUN rm -fr /scripts/setup
