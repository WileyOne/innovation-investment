# Skills & Agents Marketplace Hub — Planning Doc

*Working draft, started 2026-08-20. Branding is intentionally TBD — this doc refers to it as "the hub." Companion to the "Making it Real" deck and the action tracker.*

## Purpose

The deck frames this as "reuse and succeed from others" — a shared space where agents, prompts, and workflows people have already built become visible and reusable instead of quietly living on one person's machine. The goal isn't to be a polished product; it's to close the gap called out earlier in the deck, where some teams are already redesigning real workflows with AI while others are still just collecting productivity tips. The hub is the mechanism that lets the first group's work reach the second group.

Two existing internal hubs are worth treating as prior art rather than competitors: VibeHub, which makes AI-built prototypes and demos visible and has real traction (thousands of projects and creators), and the MCAPS Skill Shack, a role-based library of copy-paste prompts. Neither is exactly this — VibeHub is prototype-and-demo focused, Skill Shack is prompt-focused for one org — but both prove the pattern works and both are worth a look before designing this from scratch, if only to borrow submission templates or avoid rebuilding something that already exists elsewhere in the company.

## What "first step infrastructure" should actually be

The deck's note that this is "first step infrastructure" is worth taking literally: the fastest way to get this live is a GitHub repository with a clear folder structure and a lightweight index, not a custom web application. A repo gets version history, pull-request-based review, and a natural home for code and prompts for free, and a simple static index (even just a well-organized README, or a basic GitHub Pages site generated from the repo) is enough for people to browse by category. A custom front end — the actual "website," with real branding — is a later-phase investment once there's evidence people are using the repo version. Building the polished site first risks spending the effort before knowing whether the content and habit of contributing actually take hold.

## Content and structure

Each submission should follow a short template so review stays light and entries stay comparable: what problem it solves, what it is (an agent, a prompt, a workflow, a connector, a script), what tools or platforms it depends on, a rough sense of impact (time saved, quality improved, a process it replaced), and a pointer to whoever built it in case someone wants to ask questions. Organizing by category (by function — reporting, triage, research, content generation — and separately by team or business area) will matter more once volume grows, but at launch even a flat list with good tags is enough.

## Contribution and approval flow

The deck's notes call for two things that are somewhat in tension: "anyone can contribute" and "subject to approval." The way to reconcile them is to keep the bar low and the loop fast — a pull request or upload triggers a lightweight review (Dade, or a small rotating review group once volume grows) focused on quality, avoiding duplicates, and a basic security check for anything that touches real data or systems, not on gatekeeping whether the idea itself is good enough. A clear submission template does most of the review work up front by making expectations obvious before something is submitted.

## Feeding the loop: sessions and the hackathon

The hub shouldn't be a cold-start destination people have to remember to visit — it should be the natural output of the other two pillars. The bi-weekly sessions are a steady source of small, proven contributions, especially anything that comes out of a "bring your own workflow" or "connect an agent to a tool" session. The hackathon is a source of larger, more ambitious ones, particularly once a project has been hardened past prototype stage. The deck already commits to a biweekly update celebrating new and updated use cases — tying that update to session wrap-ups gives it a natural rhythm and gives contributors a reason to keep submitting: the visibility is real and it happens on a predictable schedule.

## Phased rollout

A reasonable sequence: start with the repo, folder structure, and submission template, seeded with a handful of Dade's own examples so it isn't empty on day one — an empty hub asks for a leap of faith that a seeded one doesn't. Next, invite the existing bi-weekly session roster to submit first, since they're already primed and it tests the submission and review flow at small scale before opening it up. After that, open it more broadly and pair the announcement with hackathon judging, so hackathon energy has somewhere to land immediately afterward. Real branding, a nicer front end, and wider promotion are worth investing in only once there's a track record of actual submissions and reuse — that's the point where "website marketplace" becomes literally true rather than aspirational.

## Success signals

Submission count is the easiest thing to track but the least meaningful one on its own — reuse is the real signal: how many entries get forked, adapted, or referenced by someone other than the original author, and how many teams are represented rather than just how many individuals. Worth logging informally from the start, even just a note next to each entry when someone mentions they used it, since that data will matter later for making the case to invest further in the hub.

## Open questions and risks

Long-term review ownership isn't settled — a single-approver model (Dade) works at launch but won't scale if volume grows, so it's worth deciding early who joins a review rotation. Anything that touches real company data or internal systems needs a real security review path, not just a quality check — that's a bigger decision than this doc can resolve alone. Branding and naming are deliberately deferred, but worth revisiting once there's real usage to build a name around rather than guessing up front. And it's worth explicitly checking whether this should integrate with or link out to VibeHub and Skill Shack rather than existing as a fully separate third hub, since three uncoordinated internal hubs is a worse outcome than one that people can actually find.
