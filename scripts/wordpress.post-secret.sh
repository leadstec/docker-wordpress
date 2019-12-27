#!/bin/bash

#
# wait for database
#
function wait_for_database() {
    printf "Waiting for database server '${WP_DBHOST}' to accept connections"
    prog="mysqladmin -h ${WP_DBHOST} -u ${WP_DBUSER} -p{{MARIADB_DB_PASS}} status"
    timeout=120
    while ! ${prog} >/dev/null 2>&1
    do
        timeout=$(expr $timeout - 1)
        if [ $timeout -eq 0 ]; then
            printf "\nCould not connect to database server. Aborting...\n"
            exit 1
        fi
        printf "."
        sleep 1
    done
    echo
}


# wait for dbserver to come online
wait_for_database

# Determine new install or updating
if [[ ${SETUP_MODE} == 'new' ]]; then
    # create wp-config.php
    wp core config --path="${APP_DIR}" \
        --dbhost="${WP_DBHOST}" \
        --dbname="${WP_DBNAME}" \
        --dbuser="${WP_DBUSER}" \
        --dbpass={{MARIADB_DB_PASS}} \
        --locale=zh_CN \
        --extra-php <<PHP
define('WP_DEBUG', false);
define('FS_METHOD','direct');
define('WP_ZH_CN_ICP_NUM', true);
//define('WP_CONTENT_DIR', '${LCS_PERSIST_DIR}/wordpress/wp-content');
PHP

    # install wordpress and create db tables
    if [[ ${WP_MULTISITE} == false ]]; then
        wp core install --path=${APP_DIR} \
            --url=${WP_SITE_URL} \
            --title="${WP_SITE_TITLE}" \
            --admin_user=${WP_ADMIN} \
            --admin_password="{{WP_ADMIN_PASS}}" \
            --admin_email=${WP_ADMIN_EMAIL} \
            --skip-email
        clog -i "wordpress: Single site and database installed."
    else
        # rewrite rule must be set for multisite
        WP_REWRITE_PERMALINK=true
        if [[ ${WP_MULTISITE_SUBDOMAINS} == true ]]; then
            wp core multisite-install --path=${APP_DIR} \
                --url=${WP_SITE_URL} \
                --title="${WP_SITE_TITLE}" \
                --admin_user=${WP_ADMIN} \
                --admin_password="{{WP_ADMIN_PASS}}" \
                --admin_email=${WP_ADMIN_EMAIL} \
                --skip-email \
                --subdomains
            # .htaccess
            cp -f /scripts/wpmu-config/htaccess_subdomains ${APP_DIR}/.htaccess
            clog -i "wordpress: Multisite sub-domains with database installed."
        else
            wp core multisite-install --path=${APP_DIR} \
                --url=${WP_SITE_URL} \
                --title="${WP_SITE_TITLE}" \
                --admin_user=${WP_ADMIN} \
                --admin_password="{{WP_ADMIN_PASS}}" \
                --admin_email=${WP_ADMIN_EMAIL} \
                --skip-email
            # .htaccess
            cp -f /scripts/wpmu-config/htaccess_subdir ${APP_DIR}/.htaccess
            clog -i "wordpress: Multisite sub-directories with database installed."
        fi
    fi

    # rewrite permalink
    [[ ${WP_REWRITE_PERMALINK} == true ]] && wp rewrite structure --path=${APP_DIR} '/%year%/%monthnum%/%postname%/'

    # remove hello dolly
    wp plugin uninstall --path=${APP_DIR} hello

    # if [[ ${WP_ENABLE_DEFAULT_PLUGINS} == true ]]; then
    #     # china cdn plugin
    #     wp plugin install --path=${APP_DIR} ${WP_PRIVATE_REPO}/plugins/replace-china-cdn/replace-china-cdn-1.1.zip --activate
    #     wp plugin install --path=${APP_DIR} ${WP_PRIVATE_REPO}/plugins/ldap-login-password-and-role-manager/ldap-login-password-and-role-manager.1.0.11.zip --activate
    #     # generic-openid-connect
    #     wp plugin install --path=${APP_DIR} generic-openid-connect --activate
    #     # piwik
    #     wp plugin install --path=${APP_DIR} wp-piwik --activate
    # fi
    # clog -i "wordpress: Essential plugins installed."
else
    # custom code when restore
    # create wp-config.php
    # the config file here is just for file mapping and connection checking,
    # it will be replaced by the old config
    wp core config --path="${APP_DIR}" \
        --dbhost="${WP_DBHOST}" \
        --dbname="${WP_DBNAME}" \
        --dbuser="${WP_DBUSER}" \
        --dbpass="{{MARIADB_DB_PASS}}" \
        --locale=zh_CN \
        --extra-php <<PHP
define('WP_DEBUG', false);
define('FS_METHOD','direct');
define('WP_ZH_CN_ICP_NUM', true);
//define('WP_CONTENT_DIR', '${LCS_PERSIST_DIR}/wordpress/wp-content');
PHP
    # Backup database
    mysqldump --add-drop-table --all-databases -h ${WP_DBHOST} -u ${WP_DBUSER} -p{{MARIADB_DB_PASS}} | gzip > ${LCS_PERSIST_DIR}/db_$(date "+%Y%m%d%H%M").sql.gz
    #Update wordpress database to match current installation files
    wp core update-db --path=${APP_DIR}
    clog -i "wordpress: Persistence storage restored, original db had backup and updated to current version."
fi
