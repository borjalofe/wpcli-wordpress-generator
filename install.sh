#!/bin/bash

###############################################################################
#                                                                             #
#                                                                             #
#                              Helper Functions                               #
#                                                                             #
#                                                                             #
###############################################################################

slugify() {
    [[ $# -eq 1 ]] || exit 1

    local TO_SLUGIFY=$1
    # We lowercase the string
    TO_SLUGIFY=$(echo ${TO_SLUGIFY,,})
    # We replace any non-english char with the nearest match
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//á/a})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//à/a})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ä/a})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//â/a})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ç/c})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//é/e})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//è/e})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ë/e})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ê/e})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//í/i})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ì/i})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ï/i})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//î/i})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ñ/n})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ó/o})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ò/o})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ö/o})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ô/o})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ú/u})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ù/u})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//ü/u})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//û/u})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY// /-})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//_/-})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//../-})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//·/-})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//,/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//;/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//¡/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//!/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//¿/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//?/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//(/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//)/})
    TO_SLUGIFY=$(echo ${TO_SLUGIFY//\'/})

    echo $TO_SLUGIFY
}

generate_pass() {
    # You must change this method to match your needs
    [[ $# -eq 1 ]] || exit 1

    local ADMIN_PASS=$1
    local FIRST_HALF=${ADMIN_PASS:(-4)}
    FIRST_HALF=${FIRST_HALF^^}
    FIRST_HALF=$(echo ${FIRST_HALF//A/@})
    FIRST_HALF=$(echo ${FIRST_HALF//E/#})
    FIRST_HALF=$(echo ${FIRST_HALF//I/!})
    local SECOND_HALF=${ADMIN_PASS:0:4}
    SECOND_HALF=${SECOND_HALF,,}
    FIRST_HALF=$(echo ${FIRST_HALF//a/4})
    FIRST_HALF=$(echo ${FIRST_HALF//b/8})
    FIRST_HALF=$(echo ${FIRST_HALF//e/3})
    FIRST_HALF=$(echo ${FIRST_HALF//g/6})
    FIRST_HALF=$(echo ${FIRST_HALF//i/1})
    FIRST_HALF=$(echo ${FIRST_HALF//o/0})
    FIRST_HALF=$(echo ${FIRST_HALF//q/9})
    FIRST_HALF=$(echo ${FIRST_HALF//s/5})
    FIRST_HALF=$(echo ${FIRST_HALF//t/7})
    FIRST_HALF=$(echo ${FIRST_HALF//z/2})
    ADMIN_PASS=$(echo "${FIRST_HALF}${SECOND_HALF}")

    echo $ADMIN_PASS
}

generate_db_prefix() {
    [[ $# -eq 1 ]] || echo $(echo $RANDOM | md5sum | head -c 8;echo;)"_"

    local DATE=$(date +%Y)
    local PREPROCESS_DB_PREFIX=$1
    PREPROCESS_DB_PREFIX=${PREPROCESS_DB_PREFIX,,}
    local DB_PREFIX="${PREPROCESS_DB_PREFIX:0:5}${PREPROCESS_DB_PREFIX:(-2)}_${DATE}_"

    echo $DB_PREFIX
}


###############################################################################
#                                                                             #
#                                                                             #
#                                  Defaults                                   #
#                                                                             #
#                                                                             #
###############################################################################

BASE_FOLDER=$(pwd)

# Here you can setup the basics of the script

# If you're going to use paid plugins from the beginning, you'll need to have
# them accesible from some open repo. You can set that repo here.
REPO="" 

##
# Default DB Data
##
DBHOST="localhost"

##
# Default Setup Vars
##
LOCALE="en_US"
DATE_FORMAT='m/d/Y'
TIME_FORMAT='g:i a'
TIMEZONE_STRING='America/New_York'

##
# Default Users
##
OUR_ADMIN_USER=''
OUR_ADMIN_EMAIL=''
OUR_ADMIN_FIRST_NAME=''
OUR_ADMIN_LAST_NAME=''
OUR_ADMIN_URL=''
OUR_ADMIN_DISPLAY_NAME="${OUR_ADMIN_FIRST_NAME} ${OUR_ADMIN_LAST_NAME}"
if [[ "${OUR_ADMIN_DISPLAY_NAME}" != " " ]]; then
    OUR_ADMIN_USER=$(slugify ${OUR_ADMIN_DISPLAY_NAME// /})
fi

##
# Base Menus
##
MAIN_MENU_NAME='Main Menu'
LEGAL_MENU_NAME='Legal Menu'

##
# Default Theme
##
PARENT_THEME='generatepress'

##
# Default Colors
##
PRIMARY_FG_COLOR='#000000'
PRIMARY_BG_COLOR='#ffffff'

ACCENT_BG_COLOR='#000000'
ACCENT_FG_COLOR='#ffffff'

INFO_BG_COLOR='#0000ff'
INFO_FG_COLOR='#ffffff'

SUCCESS_BG_COLOR='#00ff00'
SUCCESS_FG_COLOR='#ffffff'

WARNING_BG_COLOR='#ffff00'
WARNING_FG_COLOR='#ffffff'

DANGER_BG_COLOR='#ff0000'
DANGER_FG_COLOR='#ffffff'



###############################################################################
#                                                                             #
#                                                                             #
#                               Get User Input                                #
#                                                                             #
#                                                                             #
###############################################################################

read -p "What's your Website's Title? " TITLE

read -p "What's your Website's URL -without http(s)://-? " URL

read -p "What's your Admin User's Login? " ADMIN_USER

read -p "What's your Admin User's Email? " ADMIN_EMAIL

read -sp "What's your Admin User's Password? -we're not going to show the password- " ADMIN_PASS

echo -e "\nDo you want to setup an ecommerce?\n    - Write \"yes\" or \"y\" to do so\n    - Anything else won't setup an ecommerce"
read -p "> " HAS_ECOMMERCE

if [[ "yes" == "${HAS_ECOMMERCE}" ]]; then
    HAS_ECOMMERCE='y'
fi

if [[ "y" != "${HAS_ECOMMERCE}" ]]; then
    HAS_ECOMMERCE='n'
fi

echo -e "\nPlease, create the site's database and get all data needed for its setup:\n    - DB_USER -we assume it's the same as the DB_NAME-\n    - DB_PASS"
read -p "Press [ENTER] to continue" WHATEVER

read -p "What's the Database User? " DB_USER

read -sp "What's the Database Password? -we're not going to show the password- " DB_PASS

echo -e "\n"

##
# Generate extra setup data
##

BACKUP_IFS=$IFS;
IFS='.' read -r -a array <<< "$URL";
DOMAIN="${array[0]}";
IFS=$BACKUP_IFS

CHILD_THEME=$(echo "${DOMAIN}-child")

DB_NAME=$DB_USER
DB_PREFIX=$(generate_db_prefix ${DOMAIN})

EDITOR_USER="${DOMAIN}_editor"
EDITOR_EMAIL="editor@${URL}"
EDITOR_PASS=$(generate_pass ${EDITOR_USER})

################################################################################
#                                                                              #
#                                                                              #
#                                 Base Install                                 #
#                                                                              #
#                                                                              #
################################################################################

##
# WordPress Download
##
wp core download --locale="$LOCALE"

##
# Create and setup wp-config.php
##
wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbprefix="$DB_PREFIX" --locale="$LOCALE"

wp config set WP_DEBUG false --raw

##
# Install WordPress
##
wp core install --url="https://$URL" --title="$TITLE" --admin_user="${ADMIN_USER}" --admin_email="${ADMIN_EMAIL}" --admin_password="${ADMIN_PASS}" --skip-email

##
# Base Setup
##
wp option update blogdescription ""
wp option update blog_public 0
wp option update close_comments_days_old 90
wp option update close_comments_for_old_posts 0
wp option update date_format "${DATE_FORMAT}"
wp option update default_ping_status ""
wp option update default_pingback_flag ""
wp option update gzipcompression 1
wp option update links_updated_date_format "${DATE_FORMAT} ${TIME_FORMAT}"
wp option update medium_large_size_h 768
wp option update time_format "${TIME_FORMAT}"
wp option update timezone_string "${TIMEZONE_STRING}"
wp option update uploads_use_yearmonth_folders 0
wp option update use_smilies 0

##
# Permalink Setup
##
wp rewrite structure '/%postname%/'

################################################################################
#                                                                              #
#                                                                              #
#                                  User Setup                                  #
#                                                                              #
#                                                                              #
################################################################################

##
# We're going to create a default editor user so we can give it to our client
##
MAIN_AUTHOR=$(wp user create "${EDITOR_USER}" "${EDITOR_EMAIL}" --user_pass="${EDITOR_PASS}" --role=editor --porcelain)

if [[ $OUR_ADMIN_USER != '' ]] & [[ $OUR_ADMIN_EMAIL != '' ]]; then

    OUR_ADMIN=$(wp user create "${OUR_ADMIN_USER}" "${OUR_ADMIN_EMAIL}" --role=administrator --send-email --porcelain)

    if [[ $OUR_ADMIN_FIRST_NAME != '' ]]; then
        wp user update ${OUR_ADMIN} --first_name=${OUR_ADMIN_FIRST_NAME}
    fi

    if [[ $OUR_ADMIN_LAST_NAME != '' ]]; then
        wp user update ${OUR_ADMIN} --last_name=${OUR_ADMIN_LAST_NAME}
    fi

    if [[ $OUR_ADMIN_DISPLAY_NAME != '' ]]; then
        wp user update ${OUR_ADMIN} --user_email=${OUR_ADMIN_DISPLAY_NAME}
    fi

    if [[ $OUR_ADMIN_URL != '' ]]; then
        wp user update ${OUR_ADMIN} --user_url=${OUR_ADMIN_URL}
    fi

    MAIN_AUTHOR=OUR_ADMIN
fi

################################################################################
#                                                                              #
#                                                                              #
#                                  Menu Setup                                  #
#                                                                              #
#                                                                              #
################################################################################
MAIN_MENU=$(wp menu create "${MAIN_MENU_NAME}" --porcelain)
LEGAL_MENU=$(wp menu create "${LEGAL_MENU_NAME}" --porcelain)

################################################################################
#                                                                              #
#                                                                              #
#                                 Theme Setup                                  #
#                                                                              #
#                                                                              #
################################################################################

mkdir -p "${BASE_FOLDER}/themes/${PARENT_THEME}/l10n/"

if [[ $(ls "./themes/${PARENT_THEME}/l10n/" | grep ${LOCALE} | wc -l ) -eq 0 ]]; then
    cp "${BASE_FOLDER}/themes/default/l10n/${LOCALE}.sh" "${BASE_FOLDER}/themes/${PARENT_THEME}/l10n/${LOCALE}.sh"
fi
source "${BASE_FOLDER}/themes/${PARENT_THEME}/l10n/${LOCALE}.sh"

source "${BASE_FOLDER}/themes/${PARENT_THEME}/install.sh"

################################################################################
#                                                                              #
#                                                                              #
#                                Features Setup                                #
#                                                                              #
#                                                                              #
################################################################################

mkdir -p "${BASE_FOLDER}/content/pages/blog/" "${BASE_FOLDER}/content/pages/contact/" "${BASE_FOLDER}/content/pages/cookies/" "${BASE_FOLDER}/content/pages/home/" "${BASE_FOLDER}/content/pages/legal/" "${BASE_FOLDER}/content/pages/privacy/"

source "${BASE_FOLDER}/content/pages/home/install.sh"

source "${BASE_FOLDER}/content/pages/blog/install.sh"

source "${BASE_FOLDER}/content/pages/legal/install.sh"

source "${BASE_FOLDER}/content/pages/privacy/install.sh"

source "${BASE_FOLDER}/content/pages/cookies/install.sh"

source "${BASE_FOLDER}/content/pages/contact/install.sh"
