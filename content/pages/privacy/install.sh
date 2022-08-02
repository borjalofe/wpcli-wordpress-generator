#!/bin/bash

PRIVACY_POLICY_PAGE_NAME='Privacy Policy'

PRIVACY_POLICY_PAGE=$(wp post create --post_title="${PRIVACY_POLICY_PAGE_NAME}" --post_author="${MAIN_AUTHOR}" --post_type="page" --post_status="publish" --porcelain)
wp menu item add-post "${LEGAL_MENU}" "${PRIVACY_POLICY_PAGE}"
wp option update wp_page_for_privacy_policy "${PRIVACY_POLICY_PAGE}"
