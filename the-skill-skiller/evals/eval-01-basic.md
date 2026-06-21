# Eval 1: Basic - Building from a Raw Idea

## Input
The user runs: `/the-skill-skiller a skill that summarizes meeting transcripts into a task list`

## Expected Output
The skill enters quick build mode, asks a small focused set of questions (output + tools + depth, plus a data-sources question only if the idea touches existing data), and then:
- detects the OS and the correct paths
- presents 3-5 concepts, already single-focused
- after the choice: builds a full SKILL.md + reference if needed + 3 evals
- dry-run before writing
- runs the two-layer eval and shows the trigger-rate
- installs globally + creates a zip + delivery report

## Pass Criteria
- [ ] Asked a small focused set in quick mode (not the full deep-dive interview), and tailored the options so the user was not forced into Other repeatedly
- [ ] The built skill's name is in English gerund form (e.g. `summarizing-meeting-notes`)
- [ ] The built skill's description includes English trigger phrases
- [ ] A dry-run was shown before writing to disk
- [ ] A numeric trigger-rate was shown in the delivery report
- [ ] A zip was created + the install-prompt was injected with the correct name
