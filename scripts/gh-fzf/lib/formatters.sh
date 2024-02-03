#!/bin/bash

function get_readable_timestamp() {
  now=$(gdate -u +%s)
  timestamp=$(gdate -u --date "$1" +%s)

  diff=$((now - timestamp))

  if [[ $diff -le 60 ]]; then
    echo "$diff seconds ago"
  elif [[ $diff -le $((60 * 60)) ]]; then
    echo "$((diff / (60))) minutes ago"
  elif [[ $diff -le $((60 * 60 * 24)) ]]; then
    echo "$((diff / (60 * 60))) hours ago"
  elif [[ $diff -le $((60 * 60 * 24 * 2)) ]]; then
    echo "Yesterday"
  elif [[ $diff -le $((60 * 60 * 24 * 7)) ]]; then
    echo "$((diff / (60 * 60 * 24))) days ago"
  else
    echo "$((diff / (60 * 60 * 24 * 7))) weeks ago"
  fi
}

function get_readable_mergeable() {
  if [[ $1 == "CONFLICTING" ]]; then
    echo -e "${RED}$1${END_COLOR}"
  elif [[ $1 == "MERGEABLE" ]]; then
    echo -e "${GREEN}$1${END_COLOR}"
  else
    echo -e "${GRAY}$1${END_COLOR}"
  fi
}

function get_readable_review_decision() {
  if [[ $1 == "REVIEW_REQUIRED" ]]; then
    echo -e "${RED}$1${END_COLOR}"
  elif [[ $1 == "CHANGES_REQUESTED" ]]; then
    echo -e "${YELLOW}$1${END_COLOR}"
  elif [[ $1 == "APPROVED" ]]; then
    echo -e "${GREEN}$1${END_COLOR}"
  else
    echo -e "${GRAY}$1${END_COLOR}"
  fi
}
