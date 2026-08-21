#!/usr/bin/env bash
# Standalone: posts the bi-weekly session idea backlog as Discussions.
# Safe to run on its own — does not touch labels, issues, or the project board.
# Prereq: Discussions must already be enabled with default categories seeded
# (confirmed via the graphql query that found "Ideas").
#
# Usage: bash scripts/post-session-discussions.sh

set -euo pipefail

OWNER="WileyOne"
REPO="innovation-investment"

command -v gh >/dev/null || { echo "gh CLI not found."; exit 1; }
gh auth status >/dev/null || { echo "Not authenticated. Run: gh auth login"; exit 1; }

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
  echo "Still no 'Ideas' category found — stop and check the Discussions tab in the browser."
  exit 1
fi

echo "Repo ID: $REPO_ID"
echo "Ideas category ID: $CATEGORY_ID"

create_discussion() {
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

echo "Done. https://github.com/$OWNER/$REPO/discussions"
