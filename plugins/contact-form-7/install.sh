#!/bin/bash

##
# Plugin Install
##
wp plugin install contact-form-7 wpcf7-recaptcha --activate

##
# Plugin Setup
##
wp option patch insert wpcf7 recaptcha_v2_v3_warning false
wp option patch insert wpcf7 iqfix_recaptcha 3
wp option patch insert wpcf7 iqfix_recaptcha_source 'google.com'

##
# User TODOs
##
echo "[TASK] You must setup Google Recaptcha v3"
