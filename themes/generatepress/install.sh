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
# Install Child Theme
##
wp theme install https://generatepress.com/api/themes/generatepress_child.zip --activate

##
# Menu Setup
##
wp menu location assign ${MAIN_MENU} primary
wp widget add nav_menu footer-bar --nav_menu="${LEGAL_MENU}"

##
# Option Setup
##
if [[ $(wp option list --search="generate_settings" --field=option_name | wc -l) -eq 0 ]]; then
    wp option add generate_settings '[]' --format=json
fi

wp option patch insert generate_settings back_to_top enable
wp option patch insert generate_settings blog_layout_setting no-sidebar
wp option patch insert generate_settings container_alignment text
wp option patch insert generate_settings content_layout_setting one-container
wp option patch insert generate_settings layout_setting no-sidebar
wp option patch insert generate_settings single_layout_setting no-sidebar
