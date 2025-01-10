#!/bin/bash

# Constants -------------------------------------------------------------------

END_COLOR='\033[0;00m'

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

GRAY='\033[0;90m'

# Utils -----------------------------------------------------------------------

function get_readable_timestamp() {
  now=$(gdate -u +%s)
  timestamp=$(gdate -u --date "$1" +%s)

  diff=$((now - timestamp))

  if [[ $diff -le 60 ]]; then
    echo "$diff seconds ago"
  elif [[ $diff -le $((60*60)) ]]; then
    echo "$((diff / (60))) minutes ago"
  elif [[ $diff -le $((60*60*24)) ]]; then
    echo "$((diff / (60*60))) hours ago"
  elif [[ $diff -le $((60*60*24*2)) ]]; then
    echo "Yesterday"
  elif [[ $diff -le $((60*60*24*7)) ]]; then
    echo "$((diff / (60*60*24))) days ago"
  else
    echo "$((diff / (60*60*24*7))) weeks ago"
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

function fetch_author_me_prs() {
    local search_query="$1"

     gh pr list --search "$search_query" \
	--json number,headRepository,mergeable,reviewDecision,createdAt,title,headRepositoryOwner \
	-R "$2" \
	| jq -r
}

function fetch_review_requested_me_prs() {
    local search_query="$1"

     gh pr list --search "$search_query" \
	--json number,headRepository,mergeable,reviewDecision,createdAt,title,author,headRepositoryOwner \
	-R "$2" \
	| jq -r 
}

# Fetching --------------------------------------------------------------------

tmp_dir=$(mktemp -d)

design_system_author_me_prs="$tmp_dir/design_author"
mobile_app_author_me_prs="$tmp_dir/mobile_author"
web_app_author_me_prs="$tmp_dir/web_author"

design_system_review_requested_me_prs="$tmp_dir/design_review"
mobile_app_review_requested_me_prs="$tmp_dir/mobile_review"
web_app_review_requested_me_prs="$tmp_dir/web_review"

fetch_author_me_prs "is:open author:@me" "fintual/design-system" > "$design_system_author_me_prs" &
fetch_author_me_prs "is:open author:@me" "fintual/mobile-app" > "$mobile_app_author_me_prs" &
fetch_author_me_prs "is:open author:@me" "fintual/web-app" > "$web_app_author_me_prs" &

fetch_review_requested_me_prs "is:open user-review-requested:@me" "fintual/design-system" > "$design_system_review_requested_me_prs" &
fetch_review_requested_me_prs "is:open user-review-requested:@me" "fintual/mobile-app" > "$mobile_app_review_requested_me_prs" &
fetch_review_requested_me_prs "is:open user-review-requested:@me" "fintual/web-app" > "$web_app_review_requested_me_prs" &

wait

author_me_prs_json=$(jq -s 'add' "$design_system_author_me_prs" "$web_app_author_me_prs" "$mobile_app_author_me_prs")

author_me_prs=$(
  jq -r '.[] | "#\(.number)\t\(.headRepository.name)\t\(.mergeable)\t\(.reviewDecision)\t\(.createdAt)\t\(.title)"' <<< "$author_me_prs_json" \
    | while IFS=$'\t' read -r number head_repository mergeable review_decision created_at title; do
      readable_review_decision=$(get_readable_review_decision "$review_decision")
      readable_mergeable=$(get_readable_mergeable "$mergeable")
      readable_created_at=$(get_readable_timestamp "$created_at")

      printf "%s\t%s\t%s\t%s\t%s\t%s\n" "$number" "$title" "$readable_created_at" "$readable_review_decision" "$readable_mergeable" "$head_repository"
    done
)

review_requested_me_prs_json=$(jq -s 'add' "$design_system_review_requested_me_prs" "$mobile_app_review_requested_me_prs" "$web_app_review_requested_me_prs")

review_requested_me_prs=$(
jq -r '.[] | "#\(.number)\t\(.headRepository.name)\t\(.mergeable)\t\(.reviewDecision)\t\(.createdAt)\t\(.title)\t\(.author.login)"' <<< "$review_requested_me_prs_json" \
    | while IFS=$'\t' read -r number head_repository mergeable review_decision created_at title author; do
      readable_review_decision=$(get_readable_review_decision "$review_decision")
      readable_mergeable=$(get_readable_mergeable "$mergeable")
      readable_created_at=$(get_readable_timestamp "$created_at")

      printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$number" "$title" "$readable_created_at" "$readable_review_decision" "$readable_mergeable" "$head_repository" "$author"
    done
)

all_prs_json=$(jq -s 'add' <(echo "$author_me_prs_json") <(echo "$review_requested_me_prs_json"))

rm -rf "$tmp_dir"

# Formatting ------------------------------------------------------------------

author_me_prs_header=$(echo -e "${GRAY}author:@me${END_COLOR}")
author_me_prs_body=$(printf "%s\n" "$author_me_prs" | column -t -s $'\t' -c 80)

review_requested_me_prs_header=$(echo -e "${GRAY}review-requested:@me${END_COLOR}")
review_requested_me_prs_body=$(printf  "%s\n" "$review_requested_me_prs" | column -t -s $'\t' -c 80)

all_prs=$(cat << EOF
${author_me_prs_header}
${author_me_prs_body}
${review_requested_me_prs_header}
${review_requested_me_prs_body}
EOF
)

# Loop ------------------------------------------------------------------------

while true; do
  pr=$(echo "$all_prs" | fzf --ansi --tac)
  
  if [ -z "$pr" ]; then
    break
  fi

  if echo "$pr" | grep -q "^#[0-9]"; then
    number=$(echo "$pr" | awk '{print $1}' | tr -d '#')

    owner=$(jq -r --arg number "$number" '.[] | select(.number == ($number | tonumber)) | .headRepositoryOwner.login' <<< "$all_prs_json")
    repository=$(jq -r --arg number "$number" '.[] | select(.number == ($number | tonumber)) | .headRepository.name' <<< "$all_prs_json")

    gh pr view "$number" -R "$owner/$repository" --web

    # cwd="$HOME/work/${repository}/main"
    # kitty @ launch --copy-env --type=tab --tab-title="#$number" --cwd="$cwd" nvim -c ":Octo pr edit $number"
  fi
done
