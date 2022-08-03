#!/bin/bash

CONTACT_PAGE_NAME='Contact Us'
CONTACT_PAGE_FORM_NAME='Contact Us - Form'

##
# Generate Form
##
if [[ $(wp plugin list | grep contact-form-7 | wc -l) -eq 0 ]]; then
    source "${BASE_FOLDER}/plugins/contact-form-7/install.sh"
fi

PRIVACY_PAGE_URL=$(wp post get ${PRIVACY_POLICY_PAGE} --field=post_name)
SITE_URL=$(wp option get siteurl)

CONTACT_PAGE_FORM=$(wp post create --post_title="${CONTACT_PAGE_FORM_NAME}" --post_author="${MAIN_AUTHOR}" --post_status=publish --post_type=wpcf7_contact_form --porcelain)
wp post meta add ${CONTACT_PAGE_FORM} _additional_settings 'acceptance_as_validation: on'
wp post meta add ${CONTACT_PAGE_FORM} _form "<p><label> Your name </label>[text* your-name]</p><p><label> Your email </label>[email* your-email]</p><p><label> Subject </label>[text* your-subject]</p><p><label> Your message (optional) </label>[textarea your-message]</p><p>[acceptance your-acceptance]I have read and accepted the <a href=\"${SITE_URL}/${PRIVACY_PAGE_URL}/\" target=\"_blank\">Privacy Policy</a>[/acceptance]</p><p>[recaptcha]</p><p>[submit \"Submit\"]</p>"
wp post meta add ${CONTACT_PAGE_FORM} _locale "${LOCALE}"
wp post meta add ${CONTACT_PAGE_FORM} _mail '[]' --format=json
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail active true
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail additional_headers 'Reply-To: [your-email]'
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail attachments ''
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail body "<p>From: [your-name] <[your-email]></p><p>Subject: [your-subject]</p><p>Privacy accepted: [your-acceptance]</p><p>Message Body:</p><p>[your-message]</p><p>-- </p><p>This e-mail was sent from a contact form on [_site_title] ([_site_url])</p>"
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail exclude_blank true
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail recipient '[_site_admin_email]'
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail sender "[_site_title] <wordpress@${URL}>"
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail subject '[_site_title] "[your-subject]"'
wp post meta patch insert ${CONTACT_PAGE_FORM} _mail use_html true
wp post meta add ${CONTACT_PAGE_FORM} _mail_2 "$(wp post meta get ${CONTACT_PAGE_FORM} _mail --format=json)" --format=json
wp post meta patch update ${CONTACT_PAGE_FORM} _mail_2 active false
wp post meta add ${CONTACT_PAGE_FORM} _messages '[]' --format=json
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages accept_terms 'You must accept the terms and conditions before sending your message.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages date_too_early 'This field has a too early date.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages date_too_late 'This field has a too late date.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_date 'Please enter a date in YYYY-MM-DD format.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_email 'Please enter an email address.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_number 'Please enter a number.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_required 'Please fill out this field.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_tel 'Please enter a telephone number.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_too_long 'This field has a too long input.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_too_short 'This field has a too short input.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages invalid_url 'Please enter a URL.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages iqfix_recaptcha_no_set 'Could not verify the reCaptcha response.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages iqfix_recaptcha_response_empty 'Please verify that you are not a robot.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages mail_sent_ng 'There was an error trying to send your message. Please try again later.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages mail_sent_ok 'Thank you for your message. It has been sent.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages number_too_large 'This field has a too large number.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages number_too_small 'This field has a too small number.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages quiz_answer_not_correct 'The answer to the quiz is incorrect.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages spam 'There was an error trying to send your message. Please try again later.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages upload_failed 'There was an unknown error uploading the file.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages upload_failed_php_error 'There was an error uploading the file.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages upload_file_too_large 'The uploaded file is too large.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages upload_file_type_invalid 'You are not allowed to upload files of this type.'
wp post meta patch insert ${CONTACT_PAGE_FORM} _messages validation_error 'One or more fields have an error. Please check and try again.'

##
# Generate Page Content
##
CONTACT_PAGE_CONTENT="<!-- wp:columns --><div class=\"wp-block-columns\"><!-- wp:column --><div class=\"wp-block-column\"><!-- wp:contact-form-7/contact-form-selector --><div class=\"wp-block-contact-form-7-contact-form-selector\">[contact-form-7 id=\"${CONTACT_PAGE_FORM}\" title=\"${CONTACT_PAGE_FORM_NAME}\"]</div><!-- /wp:contact-form-7/contact-form-selector --></div><!-- /wp:column --></div><!-- /wp:columns -->"

##
# Create Page
##
CONTACT_PAGE=$(wp post create --post_author="${MAIN_AUTHOR}" --post_content="${CONTACT_PAGE_CONTENT}" --post_status="publish" --post_title="${CONTACT_PAGE_NAME}" --post_type="page" --porcelain)

##
# Page Setup
##

##
# Add Page To Menu
##
wp menu item add-post "${MAIN_MENU}" "${CONTACT_PAGE}"

##
# User TODOs
##
