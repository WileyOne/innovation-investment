# Innovation Investment — Making It Real

Working repo for the cross-team effort to turn AI adoption into prototypes, habits, and reusable patterns. Companion to the "Making it Real" deck. Three pillars, three folders:

- [`bi-weekly-sessions/`](bi-weekly-sessions/session-ideas.md) — recurring hands-on-keyboard sessions: format, cadence, and a topic backlog.
- [`marketplace-hub/`](marketplace-hub/marketplace-plan.md) — plan for a shared space for skills and agents (name/branding TBD). Contributors submit via the **Submit a skill or agent** issue form ([source](.github/ISSUE_TEMPLATE/submit-skill-or-agent.yml)); [`SUBMISSION_TEMPLATE.md`](marketplace-hub/SUBMISSION_TEMPLATE.md) documents what those fields mean.
- [`action-tracker/`](action-tracker/action_tracker.xlsx) — the original xlsx/markdown tracker pulled from the deck's notes. **Live tracking has moved to Issues + the Project board** (created by `scripts/setup-github-features.sh`) — the files here are the historical snapshot the board was seeded from.

## GitHub-native pieces

- **Action tracker → Issues + Project board.** Each tracker row is an Issue (category label, `Owner`/`Due Date`/`Category` fields on the board), closed when done.
- **Marketplace submissions → Issue form.** "New Issue" → "Submit a skill or agent" instead of copy-pasting `SUBMISSION_TEMPLATE.md`.
- **Session idea backlog → Discussions**, "Ideas" category, so people can comment/react on what to run next.

Run `bash scripts/setup-github-features.sh` once (after `gh auth login`) to create all of the above from the current files — see the script header for prerequisites.

## Status

Early planning stage — these are working drafts, not finalized commitments. See the Issues/Project board for open action items and owners.
