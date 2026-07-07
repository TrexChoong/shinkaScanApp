# Project board automation

This directory automates the [TCG Companion project board](https://github.com/users/TrexChoong/projects/3)
so it behaves like the *Choosing the next task* widget in
[`master_development_plan.html`](../../master_development_plan.html): issues surface
as **Ready** exactly when their blockers clear, and finishing a parent's sub-issues
closes the parent and cascades to whatever it was blocking.

## What already runs — the 7 built-in project workflows

These are configured in the project's **⋯ → Workflows** UI (not in this repo). All
are currently enabled:

| Workflow | What it does |
|---|---|
| Auto-add to project | New repo issues are added to the board |
| Auto-add sub-issues to project | Sub-issues of a board item are added too |
| Item added to project | Sets the starting Status for newly added items |
| Item closed | Sets **Status → Done** when an issue is closed |
| Auto-close issue | Closes an issue when it reaches a chosen Status |
| Pull request linked to issue | Reflects a linked PR on the item |
| Pull request merged | Advances the item when its PR merges |

**The gap:** built-in workflows have no notion of *dependencies* or *sub-issue
rollup*. They cannot express "set Ready once every blocker is closed" or "close the
parent when its last sub-issue closes." That logic lives in the Action below.

## What this repo adds — `board-automation.yml`

A single [`actions/github-script`](https://github.com/actions/github-script) job that
reads the native GitHub **issue dependencies** (`blocked_by` / `blocking`) and
**sub-issue** graph, then writes the project **Status** field.

| Widget behavior | Automation |
|---|---|
| An issue is *eligible* only when all its "Blocked by" issues are closed | On a blocker closing, each dependent whose blockers are now all closed is set **Status → Ready** |
| Blocked issues wait in Backlog | An open issue with any open blocker is kept at **Backlog**; if a blocker reopens, its dependents drop from Ready back to Backlog |
| Sub-issues roll up into their parent | When every sub-issue of a parent is closed, the parent is **closed** — which fires again and re-evaluates the parent's own dependents |
| Ranking is over top-level issues | Status is managed for **top-level issues only**; sub-issues (even though they're auto-added to the board) are driven by their parent's lifecycle, never by board Status |

Human-owned states are respected: the job only ever moves an item **between Backlog
and Ready**. Anything you've set to *In progress*, *In review*, or *Done* is left
untouched.

### Triggers

- `issues: [opened, closed, reopened]` — the real-time path.
- `schedule` (hourly) and `workflow_dispatch` — a full reconciliation sweep over
  every open top-level board item. **This matters:** adding or removing a
  dependency does *not* emit an issue webhook event, so a Ready/Backlog change from
  editing "Blocked by" only lands on the next hourly sweep (or when you run the
  workflow manually).

## Required setup (one-time)

The default `GITHUB_TOKEN` **cannot write to a user-owned ProjectV2**, so the job
authenticates with a token stored as the repo secret **`PROJECTS_TOKEN`**. No
`.env` is involved — the secret lives in GitHub's Actions store, and the setup
below sources the token straight from the authenticated `gh` CLI:

```bash
bash scripts/setup-project-secret.sh
```

That reuses the `gh` CLI's own token (it must have `project` + `repo` scopes — check
with `gh auth status`, add them with `gh auth refresh -s project`). For least
privilege, pass a dedicated fine-grained PAT (this repo: *Issues* + *Projects* =
Read/write) instead:

```bash
bash scripts/setup-project-secret.sh <token>
```

<details>
<summary>Without the script (any shell)</summary>

```bash
gh auth token | gh secret set PROJECTS_TOKEN --repo TrexChoong/shinkaScanApp
```
</details>

Verify with **Actions → Board dependency automation → Run workflow** (the
`workflow_dispatch` sweep). The run summary lists every Status change it made; a
clean board reports "No status changes." If the secret is missing the job fails
fast on the first project write — that's the signal to run the setup above.

## Notes & limits

- `PROJECT_OWNER` / `PROJECT_NUMBER` are set as `env` at the top of the workflow —
  update them if the board moves.
- The `Item closed → Done` built-in already handles the closed→Done transition, so
  this Action deliberately never sets Done — no conflict.
- Closing a parent via the cascade re-triggers the workflow; this is intended and
  terminates naturally (state only moves toward closed).
- The Action reflects the plan's decision to schedule at the **top-level** issue
  grain. If you later want sub-issues ranked individually, remove the
  `if (info.parent) return;` guard in `reconcile()`.
