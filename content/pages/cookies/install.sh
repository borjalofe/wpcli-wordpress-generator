#!/bin/bash

COOKIES_POLICY_PAGE_NAME='Cookies Policy'

COOKIES_POLICY_PAGE=$(wp post create --post_title="${COOKIES_POLICY_PAGE_NAME}" --post_author="${MAIN_AUTHOR}" --post_type="page" --post_status="publish" --porcelain)
wp menu item add-post "${LEGAL_MENU}" "${COOKIES_POLICY_PAGE}"
