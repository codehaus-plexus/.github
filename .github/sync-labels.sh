#!/usr/bin/env bash
# Sync the canonical codehaus-plexus label set across all active repositories.
#
#   ./sync-labels.sh            # dry run  - print what would change
#   ./sync-labels.sh --apply    # create/update the canonical labels
#   ./sync-labels.sh --apply --prune   # ... and fold the superseded ones away
#
# Deletion policy: a label is only ever deleted after every issue and PR
# carrying it has been moved onto its replacement, or if it was never used at
# all. Deleting a label in GitHub strips it from every past issue permanently
# and there is no undo, so labels that carry history and have no replacement
# (java8, hacktoberfest-accepted, wontfix, invalid) are left in place. They are
# simply no longer propagated to repos that don't already have them.
#
set -uo pipefail

DEF="$(dirname "$0")/labels.tsv"
APPLY=0; PRUNE=0
for a in "$@"; do
  case "$a" in --apply) APPLY=1 ;; --prune) PRUNE=1 ;; esac
done

REPOS=(
  plexus-archiver plexus-build-api plexus-classworlds plexus-compiler
  plexus-i18n plexus-interactivity plexus-interpolation plexus-io
  plexus-languages plexus-pom plexus-resources plexus-sec-dispatcher
  plexus-testing plexus-utils plexus-velocity plexus-xml
  modello .github codehaus-plexus.github.io
)

# superseded label -> canonical replacement
declare -A MERGE=(
  [fix]=bug
  [bugfix]=bug
  [chore]=maintenance
  [internal]=maintenance
  [plugins]=dependencies
)

# labels to remove only if they are provably unused (0 issues, 0 PRs)
DROP_IF_UNUSED=(TASK duplicate test)

run() { if [ "$APPLY" = 1 ]; then "$@"; else echo "  DRY: $*"; fi; }

DRIFT=0

# Compare a repo's live labels against the canonical file and print only the
# differences, so a dry run is a drift report rather than a list of every label.
report_drift() {
  local R="$1" live name color desc have_color have_desc
  live=$(gh label list -R "$R" --limit 200 --json name,color,description \
           --jq '.[] | [.name, (.color|ascii_upcase), (.description // "")] | @tsv')
  while IFS=$'\t' read -r name color desc; do
    [[ -z "$name" || "$name" == \#* ]] && continue
    local row; row=$(grep -F -m1 "$(printf '%s\t' "$name")" <<<"$live")
    if [ -z "$row" ]; then
      echo "  MISSING: $name"; DRIFT=1; continue
    fi
    have_color=$(cut -f2 <<<"$row"); have_desc=$(cut -f3 <<<"$row")
    if [ "$have_color" != "$(tr '[:lower:]' '[:upper:]' <<<"$color")" ]; then
      echo "  COLOUR:  $name is #$have_color, expected #$color"; DRIFT=1
    fi
    if [ "$have_desc" != "$desc" ]; then
      echo "  DESC:    $name description differs"; DRIFT=1
    fi
  done < "$DEF"
}

has_label() {
  gh label list -R "$1" --limit 200 --json name --jq '.[].name' | grep -qxF "$2"
}

# every issue and PR number carrying $2 in repo $1
tagged() {
  gh issue list -R "$1" --state all --label "$2" --limit 500 --json number --jq '.[].number'
  gh pr    list -R "$1" --state all --label "$2" --limit 500 --json number --jq '.[].number'
}

for repo in "${REPOS[@]}"; do
  R="codehaus-plexus/$repo"
  echo "=== $R"

  # 1. create or recolour the canonical set
  if [ "$APPLY" = 1 ]; then
    while IFS=$'\t' read -r name color desc; do
      [[ -z "$name" || "$name" == \#* ]] && continue
      gh label create "$name" -R "$R" --color "$color" --description "$desc" --force
    done < "$DEF"
  else
    report_drift "$R"
  fi

  [ "$PRUNE" = 1 ] || continue

  # 2. fold superseded labels into their replacement, then delete the empty definition
  for old in "${!MERGE[@]}"; do
    has_label "$R" "$old" || continue
    new="${MERGE[$old]}"
    for n in $(tagged "$R" "$old"); do
      run gh issue edit "$n" -R "$R" --add-label "$new" --remove-label "$old"
    done
    run gh label delete "$old" -R "$R" --yes
  done

  # 3. delete leftovers only when nothing references them
  for old in "${DROP_IF_UNUSED[@]}"; do
    has_label "$R" "$old" || continue
    if [ -z "$(tagged "$R" "$old")" ]; then
      run gh label delete "$old" -R "$R" --yes
    else
      echo "  KEEP: $old is in use in $R - not deleting"
    fi
  done
done

# exit non-zero when a dry run found drift, so CI can gate on it
[ "$APPLY" = 1 ] || exit $DRIFT
