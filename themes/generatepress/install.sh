#!/bin/bash

PARENT_THEME='generatepress'

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
        if [[ $optionToDelete != *"${PARENT_THEME}"* ]]; then
            wp option delete $optionToDelete;
        fi
    done
done

##
# Install child theme
##
wp theme install https://generatepress.com/api/themes/generatepress_child.zip --activate

##
# Setup Menus
##
wp menu location assign ${MAIN_MENU} primary
wp widget add nav_menu footer-bar --nav_menu="${LEGAL_MENU}"
