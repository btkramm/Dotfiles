#!/bin/bash

function open_in_nvim() {
  pr="$1"
  all_prs_json_path="$2"

  echo "$pr"
  echo "$all_prs_json_path"

  if [ -z "$pr" ]; then
    return
  fi

  if echo "$pr" | grep -q "^#[0-9]"; then
    number=$(echo "$pr" | awk '{print $1}' | tr -d '#')
    repository=$(echo "$pr" | awk '{print $2}')

    jq -r --arg number "$number" --arg repository "$repository" '
      map(select(.number == ($number | tonumber) and .headRepository.name == $repository)
      | .headRepositoryOwner.login)
      | first' "$all_prs_json_path"

    kitty @ launch \
      --copy-env \
      --type=tab \
      --tab-title="#$number" \
      --cwd="$HOME/work/${repository}/main" \
      nvim -c ":Octo pr edit $number"
  fi
}
