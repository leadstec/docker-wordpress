# Wordpress image for VCubi Platform

![Wordpress](https://img.shields.io/badge/Wordpress-5.5.1,_latest-blue)
![x86_64](https://img.shields.io/badge/x86_64-supported-brightgreen)
![aarch64](https://img.shields.io/badge/aarch64-supported-brightgreen)

## How to Use

### Pull image
    # from Docker Hub
    docker pull leadstec/wordpress:[tag]
    docker pull leadstec/wordpress-aarch64:[tag]
    # from Tencent CR
    docker pull leadstec.tencentcloudcr.com/leadstec/wordpress:[tag]
    docker pull leadstec.tencentcloudcr.com/leadstec/wordpress-aarch64:[tag]

### Build image
    docker-compose build wordpress

### LCS Schema & ENV, Secrets

| Variable              | Description               | Default | Type |
|-----------------------|---------------------------|---------|------|
| WP_SITE_TITLE         |                           | Wordpress | Env |
| WP_SITE_URL | | `hostname -f` | Env |
| WP_ADMIN | | admin | Env |
| WP_ADMIN_EMAIL | | `echo ${EMAIL}` | Env |
| WP_REWRITE_PERMALINK | | true | Env |
| WP_MULTISITE | | false | Env |
| WP_MULTISITE_SUBDOMAINS | | true | Env |
| WP_DBHOST | | localhost | Env |
| WP_DBNAME | | wordpress | Env |
| WP_DBUSER | | wordpress | Env |
| WP_ADMIN_PASS | | - | Secret |
| MARIADB_DB_PASS | | - | Secret |

## Image Structure Test
    container-structure-test test --image leadstec/wordpress:tag --config tests/wordpress.yaml

## CHANGELOG

**5.5.1 (2020/10/04)**
* Update: wp-cli -> 2.4.0
* Update: Based on Php 7.3.22

**4.9.4 2018-12-03**
* Update: lcs 1.6.2
* Update: wp-cli -> 2.0.1

**4.9.4**
* 更新wp-cli到1.5.1
* 支持aarch64

**4.9.2**

* 基于 PHP 7.1.12
* wp-cli 升级 1.4.1

**4.7.1**

* 基于PHP5 5.6.29（LCS 1.3）
* wp-cli升级到1.0.0

**4.5**

* 支持Image Schema
* 支持LCS Tools

**4.4.2**

* 4.4.2-27
    - 默认删除Hello Dolly插件
    - 添加WP_REWRITE_PERMALINK（true/false）
    - 将plugins的下载过程迁移到build过程中，减少首次run时网络连接的影响，也优化了启动时间。

* 4.4.2-24
    - 基于nginx:1.8.1, php:5.6.17
    - 支持MultiSite部署，Sub-domains及Sub-directories都支持
    - wp-cli升级到0.22.0
    - bug fix:
        + wp-content用Symbolink在个别plugin或theme中会出现问题，在wp-config中添加fix了

**4.3.1**

* 支持自动数据库升级

**4.2.2**

* 支持Captool，持久存储
* 用wp-cli命令行安装及配置

