# Skill Architecture Blueprints

Use this file when deciding on the architecture of the skill being built.
Match the blueprint to the use case. Do not over-engineer, do not under-build.

> Paths in this file are written in Mac style (`~/.claude/...`). On Windows the equivalent is
> `%USERPROFILE%\.claude\...`. The skill detects the OS and adapts automatically - see SKILL.md Step 0.

---

## Blueprint 1: Simple Single Skill
**When**: one clear task, no live data, minimal domain knowledge.
**Examples**: "draft a sales email", "summarize a meeting transcript", "format data".

```
~/.claude/skills/[name]/
└── SKILL.md
```

**Frontmatter signals**: minimal `allowed-tools` (Read, Write at most) · `model: sonnet` · no reference files.

**Body structure**:
```markdown
# [role declaration]
## Input
- $arg1: [what it means]
## Steps
1. [concrete step]
2. [concrete step]
## Output
[format + example]
## Rules
- [rule]
```

---

## Blueprint 2: Skill + Reference Files
**When**: rich domain knowledge (brand rules, business rules, schema knowledge, compliance rules) that would bloat SKILL.md.
**Examples**: "competitor analysis using our frameworks", "content in our brand voice", "BigQuery analysis with our schema".

```
~/.claude/skills/[name]/
├── SKILL.md              <- orchestration + quick start
└── reference/
    ├── [domain]-knowledge.md
    └── [examples].md
```

**Linking inside SKILL.md**:
```markdown
## Domain knowledge
Read `reference/[domain]-knowledge.md` before you start.
```

**Frontmatter signals**: `allowed-tools`: Read + task-specific tools · `model: sonnet`.

---

## Blueprint 3: Skill + Dynamic Context Injection
**When**: the skill needs live data at runtime - git state, API output, a DB query, a file listing, current metrics.
**Examples**: "analyze the current git diff", "morning report from a live CRM", "check the pipeline".

```
~/.claude/skills/[name]/
├── SKILL.md
├── scripts/
│   └── fetch-data.py    <- called via !`command`
└── reference/
    └── [knowledge].md
```

**Dynamic injection syntax** (in the SKILL.md body):
```markdown
## Current state
- Git status: !`git status --short`
- Test results: !`npm test --silent 2>&1 | tail -10`
```

**Frontmatter signals**: `allowed-tools`: Bash + the task's tools.
> On Windows use PowerShell instead of bash commands (`Get-ChildItem` instead of `ls`, etc.).

---

## Blueprint 4: Skill + Subagents
**When**: the task has genuinely separate responsibilities that benefit from: different toolsets, context isolation per responsibility, potential parallel work, different models (cheap Haiku for simple tasks, Opus only when needed).
**Examples**: "market research, planning, execution, review", "code review: security + performance + tests as three subagents".

```
~/.claude/skills/[name]/
├── SKILL.md              <- orchestrator (delegates, does not execute)
└── reference/[knowledge].md

~/.claude/agents/
├── [name]-researcher.md
├── [name]-executor.md
└── [name]-reviewer.md
```

**Subagent file template**:
```markdown
---
name: [name]-[role]
description: [specific role - when the main skill delegates exactly this task]
tools: [only what this agent needs]
model: [haiku for simple, sonnet for complex, opus only for deep reasoning]
---
## Role
You are [specific role]. When invoked, you [specific responsibility].
## Input
You receive: [exact format]
## Output
Return JSON:
{ "status": "completed|failed|needs_review", "output": "[result]", "confidence": "high|medium|low", "warnings": [] }
## Boundaries
- Only do: [your task]
- Never: [what not to do]
```

**Multi-agent communication rules**:
- Single-writer principle: each agent writes only to its own path
- Never two agents writing to the same file
- All inter-agent data as structured JSON
- The reviewer never fixes - it only reports

---

## Blueprint 5: Full Stack - Interview + Research + Creation
**When**: a complex business workflow that needs web research + file creation + multi-step reasoning. The "monster" pattern.
**Examples**: "a full competitive intelligence report", "build a business plan", "design and run a marketing campaign".

```
~/.claude/skills/[name]/
├── SKILL.md
├── reference/ (framework.md, output-templates.md)
├── scripts/[helpers].py
└── evals/ (eval-01..03)

~/.claude/agents/ ([name]-planner.md, [name]-researcher.md, [name]-synthesizer.md)
```

**Frontmatter signals**: `allowed-tools`: WebSearch, WebFetch, Write, Read, Bash, AskUserQuestion · `model: opus`.

---

## Architecture Decision Matrix

| Signal | Blueprint |
|---|---|
| Simple, no live data, minimal knowledge | 1 - Single |
| Rich domain knowledge / rules / schema | 2 - Reference |
| Needs live data at runtime | 3 - Dynamic injection |
| Separate tools / responsibilities | 4 - Subagents |
| Complex, web + files + multi-step | 5 - Full Stack |

---

## Frontmatter - Quick Reference

```yaml
# always include:
name: [gerund-name]
description: |            # with trigger phrases
allowed-tools: [exact list]
model: sonnet             # default

# include when needed:
disable-model-invocation: true   # side effects
argument-hint: [hint]     # autocomplete
```

> Non-standard fields (e.g. `effort`, `context`, `agent`) - do not include unless you verified
> they are supported in the user's Claude Code version. Prefer minimal, standard frontmatter.

## Allowed Tools Table

| Tool | Why |
|---|---|
| Read | read any file |
| Write | create new files |
| Edit | modify existing files |
| Bash | shell commands, scripts, git |
| Glob | find files by pattern |
| Grep | search file contents |
| WebSearch | live web search |
| WebFetch | fetch web pages |
| AskUserQuestion | structured multiple-choice questions |
| Agent | run subagents |
