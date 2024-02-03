#!/bin/bash

function open_in_web() {
  pr="$1"
  all_prs_json_path="$2"

  if [ -z "$pr" ]; then
    return
  fi

  if echo "$pr" | grep -q "^#[0-9]"; then
    number=$(echo "$pr" | awk '{print $1}' | tr -d '#')
    repository=$(echo "$pr" | awk '{print $2}')

    owner=$(
      jq -r --arg number "$number" --arg repository "$repository" '
	map(select(.number == ($number | tonumber) and .headRepository.name == $repository)
	| .headRepositoryOwner.login)
	| first' "$all_prs_json_path"
    )

    gh pr view "$number" -R "$owner/$repository" --web
  fi
}
