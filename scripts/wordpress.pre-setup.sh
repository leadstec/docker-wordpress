#!/bin/bash

# just a temp fix for aarch64
if [[ $(uname -m) == 'aarch64' ]]; then
    du -sh ${APP_DIR} > /dev/null 2>&1
fi
