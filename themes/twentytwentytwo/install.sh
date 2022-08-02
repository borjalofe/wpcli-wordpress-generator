#!/bin/bash

PARENT_THEME='twentytwentytwo'

##
# Theme install
##
wp theme install ${PARENT_THEME} --activate

##
# Clean outdated theme setups
##
for theme in $(wp theme list --status=inactive --field=name); do
    wp theme delete $theme
    for optionToDelete in $(wp option list --search="*${theme}*" --field=option_name); do
        wp option delete $optionToDelete;
    done
done

wp scaffold child-theme ${CHILD_THEME} --parent_theme="${PARENT_THEME}" --theme_name="${DOMAIN} Child" --activate
