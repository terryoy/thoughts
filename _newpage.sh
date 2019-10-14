#!/bin/bash

# This script standardize the procedure to create a page.
TITLE=""
TITLE_SLUG=""
CREATE_DATE=`date "+%Y-%m-%d %H:%M"`
DATESTR=`date "+%Y-%m-%d"`
FILEDIR="_drafts"
FILENAME=""
TEMPLATE="_scripts/template/post.md"
TAGS="misc"

# Page Title and slug
function get_page_title() {
  echo "page title: "
  read -p "> " TITLE

  generate_slug

  echo -e "slug from title: ${TITLE_SLUG}. \nEnter a new one if you want to replace:"
  read -p "> " confirm_slug
  if ! [ "$confirm_slug" == "" ]; then
    TITLE_SLUG=${confirm_slug}
  fi
  
  FILENAME="${FILEDIR}/${DATESTR}-${TITLE_SLUG}.md"
    
}

function generate_slug {
  TITLE_SLUG=`echo "${TITLE}" | sed -e 's/[^[:alnum:]]/-/g' | tr -s '_' | tr A-Z a-z.`
}

# TODO: Tags
function get_tags() {
  echo "choose tags: "
  ls -1p tag/ | grep '/$' | sed 's/\/$//' | sort | column
  read -p "> " TAGS
}

function create_file() {
  mkdir -p $FILEDIR
  tmpfile="/tmp/newpage.template.${RANDOM}"
  echo "create tmpfile: ${tmpfile}"
  eval "echo \"$(cat ${TEMPLATE})\"" > $tmpfile
  vi $FILENAME -c "read ${tmpfile}"
  rm $tmpfile
}

# confirm information
function confirm_info() {
  echo
  echo "Page Title: ${TITLE}"
  echo "Date: ${CREATE_DATE}"
  echo "Tags: ${TAGS}"
  echo "Page file: ${FILENAME}"
  echo 
  read -p "Are you sure to create the page?(Y/n) " confirm
 
  if [[ $confirm =~ ^[Yy]$ ]] || [[ $confirm =~ ^$ ]]
  then   
    create_file
  fi

}


echo "To be updated"

get_page_title
#get_tags
confirm_info


