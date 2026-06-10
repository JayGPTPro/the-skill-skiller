# Eval 1: Basic - Building from a Raw Idea

## Input
The user runs: `/the-skill-skiller a skill that summarizes meeting transcripts into a task list`

## Expected Output
The skill enters quick build mode, asks 2 focused questions (output + tools), and then:
- detects the OS and the correct paths
- presents 3-5 concepts, already single-focused
- after the choice: builds a full SKILL.md + reference if needed + 3 evals
- dry-run before writing
- runs the two-layer eval and shows the trigger-rate
- installs globally + creates a zip + delivery report

## Pass Criteria
- [ ] Asked exactly 2 questions in quick mode (not the full interview)
- [ ] The built skill's name is in English gerund form (e.g. `summarizing-meeting-notes`)
- [ ] The built skill's description includes English trigger phrases
- [ ] A dry-run was shown before writing to disk
- [ ] A numeric trigger-rate was shown in the delivery report
- [ ] A zip was created + the install-prompt was injected with the correct name
