# Bi-Weekly Hands-On Sessions — Planning Doc

*Working draft, started 2026-08-20. Companion to the "Making it Real" deck and the action tracker.*

## Purpose

The bi-weekly sessions are the entry point of the whole "Making it Real" effort: a recurring, low-friction way for people to actually get hands on keyboard with agentic AI rather than just hearing about it. The deck already commits to the mechanics — recurring every two weeks, Dade running the roster and scheduling, sessions led by rotating contributors, Dade dry-running content ahead of time so he can troubleshoot in the room, and any restrictions or prerequisites flagged in advance. This doc is the next layer down: what actually happens in a session, and a backlog of topics worth running.

## Session format template

A consistent shape makes the series easy to plan and easy to show up to. A reasonable default for a 45–60 minute session: a short framing (5 minutes) on the problem the session solves and why it matters for real work, a live walkthrough from the contributor (15–20 minutes) building or demoing the thing end to end, open hands-on-keyboard time (20–25 minutes) where attendees adapt it to their own task with the presenter and Dade circulating to troubleshoot, and a close (5 minutes) capturing what people built or got stuck on. That last step matters — anything working well by the end of a session is a natural candidate for the marketplace hub, and anything people got stuck on is useful raw material for the next session's prerequisites list.

## Topic backlog

These are candidate sessions, grouped loosely by theme. Each is meant to be concrete enough that a contributor could volunteer to lead it and know roughly what to build.

### Automate a recurring status report
Point an agent at whatever data or docs feed a weekly or monthly status update and have it draft the write-up. Good first session because almost everyone has a report like this, and the before/after is immediately visible.

### Turn a meeting into action items
Feed a transcript or notes into an agent that extracts owners, due dates, and open questions, then drafts the follow-up email. Pairs well with the action-tracker pattern already used for this deck's own notes.

### Bring your own workflow (open lab)
No prepared demo — attendees bring one manual, repetitive task and spend the session trying to agent-ify it with help from the room. Higher variance, but it's the session most likely to produce a hub submission because it starts from a real pain point instead of a canned example.

### Meeting-to-deck: turning notes into a presentation
Walk through going from raw notes or a doc to a drafted slide outline or full deck, similar to the workflow that produced the "Making it Real" deck itself. Useful because deck-building is a common, high-effort task.

### Data cleanup and reporting from a messy spreadsheet
Show an agent turning a messy export into a clean, formatted workbook with real formulas — a common but tedious task across most business roles.

### Customer or ticket triage
Demo an agent that reads incoming requests (tickets, emails, Slack messages) and classifies, prioritizes, or drafts first responses. Good for teams that field a high volume of similar requests.

### Prompt and context engineering fundamentals
Less of a build session, more of a "why did that agent do that" session — what's actually happening when you write a prompt or system instructions, why context and examples change behavior, and how to debug an agent that isn't doing what you want. Useful as an early session since it makes every later session easier to follow.

### Connecting an agent to an internal tool
A walkthrough of wiring an agent up to a real internal system (a ticketing tool, a database, an internal API) rather than just chat. This is the session most directly tied to the marketplace hub's "skills and agents" content, since a working connector is exactly the kind of thing worth publishing there.

### Guardrails, evaluation, and testing before you ship an agent
How to tell whether an agent is actually reliable enough to hand off to a teammate or a process — basic evaluation, spotting failure modes, and what "good enough to share" looks like. A natural gate before something graduates from a session prototype to a hub submission.

### From hackathon prototype to something reusable
Timed to run shortly after the AI Hackathon: take a hack-week project and harden it into something documented and shareable, feeding it straight into the marketplace hub. Doubles as a way to keep hackathon momentum from evaporating right after judging.

### Demo day / show and tell
Not a build session — a lighter one where several people show what they've built over the past few sessions or from the hub, with no prep required beyond a five-minute walkthrough. Good pressure valve to run every few cycles so the backlog doesn't feel like an endless treadmill of new topics.

## Roles and logistics

Dade owns the calendar invite, the contributor roster, and running through each session's material beforehand so he can help troubleshoot live rather than learning the material in the room. Each contributor owns their own session's content and demo. Prerequisites (accounts, access, installed tools) should be flagged in the invite at least a few days out, since the deck already flags this as a known risk — a session that stalls on access issues loses the hands-on-keyboard energy that's the whole point of the format.

## Tying back to the rest of the effort

Sessions are the feeder for the other two pillars: strong session outputs are candidate marketplace hub submissions, and the "bring your own workflow" and "hackathon prototype to reusable" sessions are natural bridges to the hackathon itself. Worth tracking informally — even a simple note in the session wrap-up — which sessions produced something that went on to get reused elsewhere, since that's a much better success signal than attendance alone.

## Open questions

Cadence for topic selection isn't settled — whether topics get planned a few sessions ahead, or chosen live based on the previous session's wrap-up. Also open: how contributors are recruited beyond the initial roster, and whether sessions should be recorded for people who can't attend live.
