# CHANGELOG

**2021/01/11**
* Update: Wordpress 5.6
* Update: Implement Github Actions for CI
* Update: Move to Docker Hub as default registry

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

