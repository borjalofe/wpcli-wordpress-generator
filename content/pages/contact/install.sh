#!/bin/bash

CONTACT_PAGE_NAME='Contact Us'

CONTACT_PAGE=$(wp post create --post_title="${CONTACT_PAGE_NAME}" --post_author="${MAIN_AUTHOR}" --post_type="page" --post_status="publish" --porcelain)
wp menu item add-post "${MAIN_MENU}" "${CONTACT_PAGE}"
