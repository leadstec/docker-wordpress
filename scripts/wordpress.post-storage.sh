#!/bin/bash

# tmp fix for wp-content symlink issue
sed -i "s|//define('WP_CONTENT_DIR'|define('WP_CONTENT_DIR'|" ${APP_DIR}/wp-config.php