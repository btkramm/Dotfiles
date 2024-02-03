#!/bin/bash

function fetch_prs() {
  local search_query="$1"

  gh pr list --search "$search_query" \
    --json number,headRepository,mergeable,reviewDecision,createdAt,title,author,headRepositoryOwner,body \
    -R "$2" \
    | jq -r 'map(. + { reviewDecision: (if .reviewDecision == null or .reviewDecision == "" then "UNKNOWN" else .reviewDecision end) })'
}
