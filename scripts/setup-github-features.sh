#!/usr/bin/env bash
# One-time setup: converts the action tracker into Issues + a Projects (v2) board,
# and posts the bi-weekly session idea backlog as Discussions.
#
# Prereqs:
#   - gh CLI installed and authenticated (`gh auth status`) with a token that has
#     `repo` and `project` scopes. If you authenticated with `gh auth login` and
#     picked the default scopes, you're covered; if not: `gh auth refresh -s project`
#   - jq installed (`sudo apt install -y jq` if missing)
#   - Run from anywhere; OWNER/REPO are set below, not inferred from cwd.
#   - Safe-ish to re-run for issues/discussions (gh will just create duplicates,
#     it does not dedupe) — intended to run ONCE. If it partially fails, fix the
#     error and re-run only the section that failed rather than the whole script.
#
# Usage: bash scripts/setup-github-features.sh

set -euo pipefail

OWNER="WileyOne"
REPO="innovation-investment"

command -v gh >/dev/null || { echo "gh CLI not found. Install it first: sudo apt install gh -y"; exit 1; }
command -v jq >/dev/null || { echo "jq not found. Install it first: sudo apt install jq -y"; exit 1; }
gh auth status >/dev/null || { echo "Not authenticated. Run: gh auth login"; exit 1; }

echo "=================================================="
echo " 1) Labels"
echo "=================================================="
gh label create "bi-weekly-sessions" --color "1F77B4" --description "Bi-weekly hands-on session pillar" --repo "$OWNER/$REPO" 2>/dev/null || echo "  (label already exists, skipping)"
gh label create "marketplace-hub"    --color "6F42C1" --description "Skills & agents marketplace hub pillar" --repo "$OWNER/$REPO" 2>/dev/null || echo "  (label already exists, skipping)"
gh label create "ai-hackathon"       --color "F0883E" --description "AI Hackathon pillar" --repo "$OWNER/$REPO" 2>/dev/null || echo "  (label already exists, skipping)"
gh label create "submission"         --color "2EA44F" --description "Marketplace hub submission" --repo "$OWNER/$REPO" 2>/dev/null || echo "  (label already exists, skipping)"

echo "=================================================="
echo " 2) Project board"
echo "=================================================="
PROJECT_JSON=$(gh project create --owner "$OWNER" --title "Making It Real - Action Tracker" --format json)
PROJECT_NUMBER=$(echo "$PROJECT_JSON" | jq -r '.number')
PROJECT_ID=$(echo "$PROJECT_JSON" | jq -r '.id')
echo "  Created project #$PROJECT_NUMBER: $(echo "$PROJECT_JSON" | jq -r '.url')"

echo "  Adding custom fields (Owner, Due Date, Category)..."
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" --name "Owner" --data-type TEXT
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" --name "Due Date" --data-type DATE
gh project field-create "$PROJECT_NUMBER" --owner "$OWNER" --name "Category" --data-type SINGLE_SELECT \
  --single-select-options "Bi-Weekly Sessions,Marketplace Hub,AI Hackathon"

FIELDS_JSON=$(gh project field-list "$PROJECT_NUMBER" --owner "$OWNER" --format json)
OWNER_FIELD_ID=$(echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name=="Owner") | .id')
DUE_FIELD_ID=$(echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name=="Due Date") | .id')
CATEGORY_FIELD_JSON=$(echo "$FIELDS_JSON" | jq -r '.fields[] | select(.name=="Category")')
CATEGORY_FIELD_ID=$(echo "$CATEGORY_FIELD_JSON" | jq -r '.id')

cat_option_id() {
  echo "$CATEGORY_FIELD_JSON" | jq -r --arg n "$1" '.options[] | select(.name==$n) | .id'
}

echo "=================================================="
echo " 3) Issues (from the action tracker)"
echo "=================================================="

create_issue() {
  # args: title, body, label, owner, due(YYYY-MM-DD or ""), category
  local title="$1" body="$2" label="$3" ownerval="$4" due="$5" category="$6"
  local url item_id catid

  url=$(gh issue create --repo "$OWNER/$REPO" --title "$title" --body "$body" --label "$label" | tail -n1)
  echo "  Issue created: $url"

  item_id=$(gh project item-add "$PROJECT_NUMBER" --owner "$OWNER" --url "$url" --format json | jq -r '.id')
  gh project item-edit --id "$item_id" --project-id "$PROJECT_ID" --field-id "$OWNER_FIELD_ID" --text "$ownerval" >/dev/null

  if [ -n "$due" ]; then
    gh project item-edit --id "$item_id" --project-id "$PROJECT_ID" --field-id "$DUE_FIELD_ID" --date "$due" >/dev/null
  fi

  catid=$(cat_option_id "$category")
  gh project item-edit --id "$item_id" --project-id "$PROJECT_ID" --field-id "$CATEGORY_FIELD_ID" --single-select-option-id "$catid" >/dev/null
}

echo "-- Bi-Weekly Sessions --"
create_issue "Schedule recurring hands-on session every 2 weeks" \
  "From the *Making it Real* deck, Bi-Weekly Sessions pillar." \
  "bi-weekly-sessions" "Dade" "" "Bi-Weekly Sessions"

create_issue "Build and maintain roster of contributors (rotating presenters)" \
  "From the *Making it Real* deck, Bi-Weekly Sessions pillar." \
  "bi-weekly-sessions" "Dade" "" "Bi-Weekly Sessions"

create_issue "Contributors lead walkthroughs, hands-on-keyboard format" \
  "From the *Making it Real* deck, Bi-Weekly Sessions pillar." \
  "bi-weekly-sessions" "Rotating contributor" "" "Bi-Weekly Sessions"

create_issue "Dry-run each session's content ahead of time to be able to troubleshoot live" \
  "From the *Making it Real* deck, Bi-Weekly Sessions pillar." \
  "bi-weekly-sessions" "Dade" "" "Bi-Weekly Sessions"

create_issue "Flag any restrictions / prerequisites (access, licensing, environment) per session" \
  "From the *Making it Real* deck, Bi-Weekly Sessions pillar." \
  "bi-weekly-sessions" "Dade" "" "Bi-Weekly Sessions"

echo "-- Marketplace Hub --"
create_issue "Stand up first-step marketplace hub for skills and agents (branding TBD)" \
  "From the *Making it Real* deck, Marketplace Hub pillar. See marketplace-hub/marketplace-plan.md." \
  "marketplace-hub" "Dade" "" "Marketplace Hub"

create_issue "Wire up backend to GitHub (or other repository) for hub content" \
  "From the *Making it Real* deck, Marketplace Hub pillar." \
  "marketplace-hub" "Dade" "" "Marketplace Hub"

create_issue "Design approval workflow so community can upload contributions subject to review" \
  "From the *Making it Real* deck, Marketplace Hub pillar." \
  "marketplace-hub" "Dade" "" "Marketplace Hub"

create_issue "Set up biweekly update highlighting new/updated/great use cases (Celebrate great ideas)" \
  "From the *Making it Real* deck, Marketplace Hub pillar." \
  "marketplace-hub" "Dade" "" "Marketplace Hub"

echo "-- AI Hackathon --"
create_issue "Craft hackathon scope and send announcement email" \
  "EOD 8/21 per AI Hackathon notes slide." \
  "ai-hackathon" "Dade & Locky" "2026-08-21" "AI Hackathon"

create_issue "Finalize team format: groups of 2-3, no two people from the same immediate team" \
  "Locky's proposal, per notes slide." \
  "ai-hackathon" "Locky" "" "AI Hackathon"

create_issue "Define project judging criteria: AI sophistication, vision for scale, hypothesis on company impact" \
  "Cost/time/effort savings or quality gain. Per notes slide." \
  "ai-hackathon" "Dade & Locky" "" "AI Hackathon"

create_issue "Plan presentation timing at team week" \
  "E.g. ~10 min per team across ~8 teams. Per notes slide." \
  "ai-hackathon" "Dade & Locky" "" "AI Hackathon"

create_issue "Decide scoring approach and confirm judges" \
  "Candidates mentioned: Mike? Jessica? Takeshi? Per notes slide." \
  "ai-hackathon" "Dade & Locky" "" "AI Hackathon"

create_issue "Confirm prize budget/details with Maria" \
  "'Huge prizes from Maria' on Making it Real slide." \
  "ai-hackathon" "Dade" "" "AI Hackathon"

create_issue "Confirm dinner prize with Jessica (she doesn't know yet)" \
  "Flagged on Making it Real slide." \
  "ai-hackathon" "Dade" "" "AI Hackathon"

create_issue "Leave winner/prize structure open for Locky to finalize" \
  "Per notes slide." \
  "ai-hackathon" "Locky" "" "AI Hackathon"

echo "  Project board ready: $(echo "$PROJECT_JSON" | jq -r '.url')"

echo "=================================================="
echo " 4) Discussions (session idea backlog)"
echo "=================================================="

gh api -X PATCH "repos/$OWNER/$REPO" -f has_discussions=true >/dev/null
echo "  Discussions enabled."

REPO_ID=$(gh api graphql -f query='
  query($owner:String!,$name:String!){
    repository(owner:$owner,name:$name){ id }
  }' -f owner="$OWNER" -f name="$REPO" --jq '.data.repository.id')

CATEGORY_ID=$(gh api graphql -f query='
  query($owner:String!,$name:String!){
    repository(owner:$owner,name:$name){
      discussionCategories(first:10){ nodes{ id name } }
    }
  }' -f owner="$OWNER" -f name="$REPO" --jq '.data.repository.discussionCategories.nodes[] | select(.name=="Ideas") | .id')

if [ -z "$CATEGORY_ID" ]; then
  echo "  Could not find an 'Ideas' discussion category — GitHub may need a minute after enabling Discussions."
  echo "  Re-run just this section after checking Settings > General > Features > Discussions."
  exit 1
fi

create_discussion() {
  # args: title, body
  local title="$1" body="$2" url
  url=$(gh api graphql -f query='
    mutation($repoId:ID!,$catId:ID!,$title:String!,$body:String!){
      createDiscussion(input:{repositoryId:$repoId,categoryId:$catId,title:$title,body:$body}){
        discussion{ url }
      }
    }' -f repoId="$REPO_ID" -f catId="$CATEGORY_ID" -f title="$title" -f body="$body" \
    --jq '.data.createDiscussion.discussion.url')
  echo "  Discussion created: $url"
}

create_discussion "Session idea: Automate a recurring status report" \
  "Point an agent at whatever data or docs feed a weekly or monthly status update and have it draft the write-up. Good first session because almost everyone has a report like this, and the before/after is immediately visible."

create_discussion "Session idea: Turn a meeting into action items" \
  "Feed a transcript or notes into an agent that extracts owners, due dates, and open questions, then drafts the follow-up email. Pairs well with the action-tracker pattern already used for this project's own notes."

create_discussion "Session idea: Bring your own workflow (open lab)" \
  "No prepared demo — attendees bring one manual, repetitive task and spend the session trying to agent-ify it with help from the room. Higher variance, but it's the session most likely to produce a marketplace hub submission because it starts from a real pain point instead of a canned example."

create_discussion "Session idea: Meeting-to-deck — turning notes into a presentation" \
  "Walk through going from raw notes or a doc to a drafted slide outline or full deck. Useful because deck-building is a common, high-effort task."

create_discussion "Session idea: Data cleanup and reporting from a messy spreadsheet" \
  "Show an agent turning a messy export into a clean, formatted workbook with real formulas — a common but tedious task across most business roles."

create_discussion "Session idea: Customer or ticket triage" \
  "Demo an agent that reads incoming requests (tickets, emails, Slack messages) and classifies, prioritizes, or drafts first responses. Good for teams that field a high volume of similar requests."

create_discussion "Session idea: Prompt and context engineering fundamentals" \
  "Less of a build session, more of a 'why did that agent do that' session — what's actually happening when you write a prompt or system instructions, why context and examples change behavior, and how to debug an agent that isn't doing what you want. Useful as an early session since it makes every later session easier to follow."

create_discussion "Session idea: Connecting an agent to an internal tool" \
  "A walkthrough of wiring an agent up to a real internal system (a ticketing tool, a database, an internal API) rather than just chat. Directly tied to the marketplace hub's 'skills and agents' content — a working connector is exactly the kind of thing worth publishing there."

create_discussion "Session idea: Guardrails, evaluation, and testing before you ship an agent" \
  "How to tell whether an agent is actually reliable enough to hand off to a teammate or a process — basic evaluation, spotting failure modes, and what 'good enough to share' looks like. A natural gate before something graduates from a session prototype to a hub submission."

create_discussion "Session idea: From hackathon prototype to something reusable" \
  "Timed to run shortly after the AI Hackathon: take a hack-week project and harden it into something documented and shareable, feeding it straight into the marketplace hub. Doubles as a way to keep hackathon momentum from evaporating right after judging."

create_discussion "Session idea: Demo day / show and tell" \
  "Not a build session — a lighter one where several people show what they've built over the past few sessions or from the hub, with no prep required beyond a five-minute walkthrough. Good pressure valve to run every few cycles."

echo "=================================================="
echo " Done."
echo "   Project board: $(echo "$PROJECT_JSON" | jq -r '.url')"
echo "   Issues:        https://github.com/$OWNER/$REPO/issues"
echo "   Discussions:   https://github.com/$OWNER/$REPO/discussions"
echo "=================================================="
