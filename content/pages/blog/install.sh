#!/bin/bash

BLOG_PAGE_NAME='Blog'

##
# Generate Page Content
##

##
# Create Page
##
BLOG_PAGE=$(wp post create --post_title="${BLOG_PAGE_NAME}" --post_author="${MAIN_AUTHOR}" --post_type="page" --post_status="publish" --porcelain)

##
# Page Setup
##
wp option update page_for_posts "${BLOG_PAGE}"

##
# Add Page To Menu
##
wp menu item add-post "${MAIN_MENU}" "${BLOG_PAGE}"

##
# User TODOs
##
