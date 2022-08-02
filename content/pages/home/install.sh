#!/bin/bash

HOME_PAGE_NAME='Homepage'

HOME_PAGE=$(wp post create --post_title="${HOME_PAGE_NAME}" --post_author="${MAIN_AUTHOR}" --post_type="page" --post_status="publish" --porcelain)
wp option update show_on_front 'page'
wp option update page_on_front "${HOME_PAGE}"
wp menu item add-post "${MAIN_MENU}" "${HOME_PAGE}"
