#!/bin/bash

LEGAL_NOTICE_PAGE_NAME='Legal Notice'

LEGAL_NOTICE_PAGE=$(wp post create --post_title="${LEGAL_NOTICE_PAGE_NAME}" --post_author="${MAIN_AUTHOR}" --post_type="page" --post_status="publish" --porcelain)
wp menu item add-post "${LEGAL_MENU}" "${LEGAL_NOTICE_PAGE}"
