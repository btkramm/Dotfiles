#!/bin/bash

DIRNAME="$(dirname "${BASH_SOURCE[0]}")"

source "$DIRNAME/lib/colors.sh"
source "$DIRNAME/lib/formatters.sh"
source "$DIRNAME/lib/gh.sh"

# Fetching --------------------------------------------------------------------

prs_json_path=$(mktemp)

tmp_dir=$(mktemp -d)

nacho_design_system_prs_json_path="$(mktemp -p "$tmp_dir")"
nacho_mobile_app_prs_json_path="$(mktemp -p "$tmp_dir")"
nacho_web_app_prs_json_path="$(mktemp -p "$tmp_dir")"

fetch_prs "is:open author:nacho_fintual" "fintual/design-system" > "$nacho_design_system_prs_json_path" &
fetch_prs "is:open author:nacho_fintual" "fintual/mobile-app" > "$nacho_mobile_app_prs_json_path" &
fetch_prs "is:open author:nacho_fintual" "fintual/web-app" > "$nacho_web_app_prs_json_path" &

tamara_design_system_prs_json_path="$(mktemp -p "$tmp_dir")"
tamara_mobile_app_prs_json_path="$(mktemp -p "$tmp_dir")"
tamara_web_app_prs_json_path="$(mktemp -p "$tmp_dir")"

fetch_prs "is:open author:tamara_fintual" "fintual/design-system" > "$tamara_design_system_prs_json_path" &
fetch_prs "is:open author:tamara_fintual" "fintual/mobile-app" > "$tamara_mobile_app_prs_json_path" &
fetch_prs "is:open author:tamara_fintual" "fintual/web-app" > "$tamara_web_app_prs_json_path" &

wait

jq -s 'add' \
  "$nacho_design_system_prs_json_path" \
  "$nacho_mobile_app_prs_json_path" \
  "$nacho_web_app_prs_json_path" \
  "$tamara_design_system_prs_json_path" \
  "$tamara_mobile_app_prs_json_path" \
  "$tamara_web_app_prs_json_path" \
  > "$prs_json_path"

rm -rf "$tmp_dir"

# Formatting ------------------------------------------------------------------

prs=$(
  jq -r '.[] | "#\(.number)\t\(.headRepository.name)\t\(.mergeable)\t\(.reviewDecision)\t\(.createdAt)\t\(.title)\t\(.author.login)"' "$prs_json_path" \
    | while IFS=$'\t' read -r number head_repository mergeable review_decision created_at title author; do
      readable_review_decision=$(get_readable_review_decision "$review_decision")
      readable_mergeable=$(get_readable_mergeable "$mergeable")
      readable_created_at=$(get_readable_timestamp "$created_at")

      printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$number" "$head_repository" "$title" "$readable_created_at" "$readable_review_decision" "$readable_mergeable" "$author"
    done
)

prs_as_columns=$(printf "%s\n" "$prs" | column -t -s $'\t' -c 80)

echo "$prs_as_columns" | fzf \
  --ansi \
  --header="author:nacho_fintual + author:tamara_fintual" \
  --reverse \
  --tac \
  --preview "
    source $DIRNAME/lib/preview.sh;

    preview {} \"$prs_json_path\"
  " \
  --bind "ctrl-o:execute(
    source $DIRNAME/lib/open_in_nvim.sh;

    open_in_nvim {} \"$prs_json_path\"
  )" \
  --bind "enter:execute(
    source $DIRNAME/lib/open_in_web.sh;

    open_in_web {} \"$prs_json_path\"
  )" \
  --bind "ctrl-d:execute(
    source $DIRNAME/lib/diff.sh;

    diff {} \"$prs_json_path\"
  )"
