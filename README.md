# Innovation Investment — Making It Real

This is the working repo for the AI adoption push from the "Making it Real" deck — bi-weekly hands-on sessions, a shared space for skills and agents, and the AI Hackathon. Three folders, roughly matching the three things we're actually trying to build:

- [`bi-weekly-sessions/`](bi-weekly-sessions/session-ideas.md) — how the sessions are run, plus a backlog of topic ideas.
- [`marketplace-hub/`](marketplace-hub/marketplace-plan.md) — the plan for a shared space for skills and agents (still no name for it, branding's TBD).
- [`action-tracker/`](action-tracker/action_tracker.xlsx) — where this all started, as a spreadsheet. Kept here for the record, but it's not where the live tracking happens anymore — see below.

## Setup

If you're cloning this fresh:

```bash
git clone https://github.com/WileyOne/innovation-investment.git
cd innovation-investment

git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

Use whatever email is verified on your GitHub account — that's how commits get linked to your profile. If you don't want your real address in the history, grab the private one from [github.com/settings/emails](https://github.com/settings/emails) instead.

Nothing fancy for making changes — branch, commit, push, PR:

```bash
git checkout -b your-branch-name
# make your changes
git add -A
git commit -m "Describe the change"
git push -u origin your-branch-name
```

Then open a PR at [github.com/WileyOne/innovation-investment/compare](https://github.com/WileyOne/innovation-investment/compare).

One more thing worth knowing: the Issues, Project board, and Discussions this README points to didn't exist as empty GitHub features — they got created by running `scripts/setup-github-features.sh` once, with the [GitHub CLI](https://cli.github.com/) authenticated (`repo` and `project` scopes):

```bash
gh auth login
gh auth refresh -s project
```

That script only needs to run once. Don't re-run it — it'll duplicate the issues and discussions instead of updating them. If you need to add a couple of things, do it by hand.

## How this actually gets used

Short version: the folders above are the plan, but the day-to-day work happens in Issues, Projects, and Discussions. Here's where each thing lives now.

### Tracking what's actually happening

The [Project board](https://github.com/users/WileyOne/projects/1) is the fastest way to see what's live — each card has an owner, a due date, and a category, plus the usual status column. If you pick something up, drag it to "In Progress." Close the issue when it's done. If you're debating something or hit a blocker, put it in the comments on that issue rather than Slack or email — it's a lot easier to find later. The full list also lives in [Issues](https://github.com/WileyOne/innovation-investment/issues), if you'd rather scroll than look at cards.

### Deciding what the next session should be

The topic backlog moved to [Discussions](https://github.com/WileyOne/innovation-investment/discussions), under "Ideas." Before I schedule the next one, I'm going to check what's getting comments or reactions and just run whichever's got the most pull. If you want to see something specific, say so there — and if the backlog's running dry, add your own idea. Claiming a date is as easy as commenting "I've got this one for 9/3."

### Submitting something to the hub

If you built something worth sharing, use the [**Submit a skill or agent**](https://github.com/WileyOne/innovation-investment/issues/new/choose) issue form instead of digging up a template. It's a few quick fields — what it does, how to reuse it, who to bug with questions. (The fields are documented in [`SUBMISSION_TEMPLATE.md`](marketplace-hub/SUBMISSION_TEMPLATE.md) if you want to see them before you start.) These come in tagged `submission` — you can see them all at once [here](https://github.com/WileyOne/innovation-investment/issues?q=is%3Aissue+label%3Asubmission). I'm not trying to gatekeep good ideas here — review just means a quick check for dupes and anything sensitive before I close it out as approved.

### The part I still do by hand

Every couple weeks I go through what's newly closed under `submission` and what's new in Discussions, and share it out so people actually see it. Haven't automated that part yet, and honestly it's a nice excuse to actually read what people built instead of just tracking that it exists.

## Where things stand

Still early — treat everything here as a working draft, not a finished process. The Project board has the real picture of what's open and who owns it.
