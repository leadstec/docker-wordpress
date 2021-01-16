# Wordpress image for VCubi Platform

![Version](https://img.shields.io/badge/Wordpress-5.6-blue)
![Arch](https://img.shields.io/badge/Arch-amd64,_arm64-brightgreen)
![Workflow](https://github.com/leadstec/docker-wordpress/workflows/ci/badge.svg)

The project contains Wordpress image for VCubi platform, based on LCS container management daemon.

Image on [DockerHub](https://hub.docker.com/r/leadstec/wordpress)

LEADSTEC: [Official website](https://www.leadstec.com)

## How to Use
    # Pull image
    docker pull leadstec/wordpress:latest

    # Build image
    docker-compose build

    # Image Structure Test
    container-structure-test test --image leadstec/wordpress:tag --config tests/wordpress.yml

## LCS Schema & ENV, Secrets

| Variable              | Description               | Default | Type |
|-----------------------|---------------------------|---------|------|
| WP_SITE_TITLE         |                           | Wordpress | Env |
| WP_SITE_URL | | `hostname -f` | Env |
| WP_ADMIN | | admin | Env |
| WP_ADMIN_EMAIL | | | Env |
| WP_REWRITE_PERMALINK | | true | Env |
| WP_MULTISITE | | false | Env |
| WP_MULTISITE_SUBDOMAINS | | true | Env |
| WP_DBHOST | | localhost | Env |
| WP_DBNAME | | wordpress | Env |
| WP_DBUSER | | wordpress | Env |
| WP_ADMIN_PASS | | - | Secret |
| MARIADB_DB_PASS | | - | Secret |

