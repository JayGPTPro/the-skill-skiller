# The Quality Manifesto - What Turns a Skill into a "Monster"

Apply every principle in this file before you call a skill done.
A skill that violates these principles is not ready - it is a draft.

---

## Gate 0 - The Single-Focus Gate

**This is the first gate. Pass it before anything else.**

Before building, make sure the skill does **one thing excellently**, not 20 things averagely.
If the user asked for a broad skill ("a marketing assistant", "an admin tool") - **stop and narrow it down** before proceeding.

| ❌ Too broad | ✅ Focused |
|---|---|
| "Marketing assistant" | "Writes cart-abandonment emails for Shopify" |
| "Admin tool" | "Summarizes meeting transcripts into a task list" |
| "Legal assistant" | "Flags risk clauses in NDAs against a US-standard checklist" |

**How to enforce the gate:**
1. If the request includes more than one clear task - show the user the breakdown: "I spotted 3 different tasks here. An excellent skill does one. Which do we focus on?"
2. Pick the task with the highest ROI that can be given a precise process.
3. The remaining tasks - propose them as separate future skills (list them in the delivery report).

The narrower the task, the more relevant rules, knowledge and processes you can define, and the more accurate the result.

---

## The 10 Monster Rules

### Rule 1: The Description Is the Soul of the Skill
The description is the most important field. Claude picks from 100+ skills based on the description alone.
A bad description = a skill that never triggers.

**Must contain:**
- WHAT: what it does (third person, specific verb)
- WHEN: the exact conditions for use
- TRIGGERS: verbatim phrases a user would actually say

**Good:**
```
Analyzes competitive landscapes and generates battle cards.
Use when a user asks about competitors, market positioning, or differentiation.
Triggers on: "analyze the competition", "compare us to [company]", "who are our competitors".
```

**Bad:**
```
Helps with competitive analysis.
```

> Write the trigger phrases exactly the way the user would phrase the request.

---

### Rule 2: Gerund-Form Names - No Compromises
Name format: `analyzing-X`, `processing-Y`, `generating-Z`, `researching-Q`
Never: `helper`, `tool`, `utils`, `my-skill`, `analyzer`
Maximum 64 characters, lowercase + hyphens only, always in English.

---

### Rule 3: Maximum 500 Lines in SKILL.md
Every token in the skill body costs you for the entire session. Challenge every sentence: "Does Claude already know this?"
If yes, delete it.
If it is domain-specific knowledge over 150 lines, move it to a reference file.

**The test**: can you explain what each paragraph adds that Claude does not already know?

---

### Rule 4: Hallucination Prevention Is Architecture
If the skill states facts, numbers, prices, competitor data, or anything that changes over time, there **must** be a tool call that fetches it.

**Wrong**: "The current market size is roughly $4.2B"
**Right**: "Fetch the current market size via WebSearch before stating it"

For the full prevention mechanism, see `reference/hallucination-contract.md`.
A skill that can hallucinate is a liability, not an asset.

---

### Rule 5: Side Effects Require a Human Key
Any skill that:
- sends emails or messages
- commits or pushes code
- charges money
- modifies a database
- posts to social media
- deletes anything

**must** have `disable-model-invocation: true`. The human, not the agent, holds the trigger.

---

### Rule 6: Progressive Disclosure Is Not Optional
```
SKILL.md     -> overview, navigation, core steps
reference/   -> detailed domain knowledge, schemas, templates
evals/       -> test scenarios
scripts/     -> runnable helpers
```

Reference files load **on demand**, never up front. Link to them explicitly: "Read reference/X.md before continuing."

> ⚠️ Careful: this is the opposite of building a Custom GPT. In a GPT you cram all the knowledge into Instructions. In a skill you push it out to reference/ and keep SKILL.md lean.

---

### Rule 7: Every Skill Has Explicit Boundaries
```markdown
## Boundaries
Allowed:
- reading files from [path]
- creating reports in [format]
- using [specific API, read-only]

Forbidden:
- modifying the database
- accessing folders outside [path]
- sending deliverables directly to customers
- financial actions
```

Boundaries prevent scope creep. Without them the skill will try to do everything.

---

### Rule 8: At Least One Concrete Example per Skill
```markdown
## Example
Input: [specific, realistic input]
Output:
[a concrete example of what the skill produces]
```

Examples anchor Claude to the correct output format better than any description.

---

### Rule 9: Build Evals Before You Call a Skill "Ready"
Three eval types - always:
1. **Basic**: a standard happy-path scenario
2. **Realistic**: a complex real-world case with messy input
3. **Edge / failure**: what happens with bad, partial, or unusual input

The eval engine in `reference/eval-engine.md` explains how to actually run them and measure trigger-rate and output quality.

---

### Rule 10: Test Against All Three Models
Before releasing any skill, mentally test it against:
- **Haiku**: needs more explicit guidance, less "reading between the lines"
- **Sonnet**: the target - balanced, capable
- **Opus**: over-explaining annoys it; too terse fails too

Optimize for Sonnet. If you need more for Haiku, add it to reference files, never to SKILL.md.

---

## Anti-Pattern Catalog

| Anti-pattern | The problem | The fix |
|---|---|---|
| `description: "helps with stuff"` | never triggers | specific verb + triggers |
| SKILL.md > 500 lines | context budget destroyed | move to reference/ |
| factual claims without tools | hallucination risk | WebSearch/WebFetch/Read |
| no example | wrong output format | add input/output example |
| `disable-model-invocation: false` on an email-sending skill | rogue agent | set true |
| all knowledge in SKILL.md | slow, expensive | progressive disclosure |
| over-broad tool list (`*`) | security, confusion | minimal explicit list |
| vague workflow steps | inconsistent output | number and define each step |
| no boundaries section | scope creep | add allowed/forbidden |
| no evals | unknown quality | minimum 3 evals |
| description overlaps an existing skill | neither triggers | run collision detection (eval-engine) |

---

## Quality Checklist - Before Every Release

```
SINGLE-FOCUS
[ ] the skill does one well-defined thing
[ ] additional tasks were deferred to other skills

DESCRIPTION
[ ] specific verb in third person
[ ] WHAT + WHEN included
[ ] trigger phrases (in the skill's language)
[ ] under 1,536 characters
[ ] passed collision detection against installed skills

NAME
[ ] gerund form
[ ] lowercase + hyphens only, English
[ ] under 64 characters

STRUCTURE
[ ] SKILL.md < 500 lines
[ ] reference files for domain knowledge > 150 lines
[ ] maximum one level of depth for references

SAFETY
[ ] disable-model-invocation: true if there are side effects
[ ] explicit boundaries section (allowed/forbidden)
[ ] no hallucination-prone factual claims

QUALITY
[ ] at least one concrete example
[ ] numbered, specific workflow steps
[ ] 3 evals written
[ ] trigger-rate measured and above threshold
[ ] output quality tested (Layer B eval)
[ ] success metrics defined

TOOLS
[ ] minimal, exact tool list
[ ] no unnecessary tools
[ ] live data via tools, not hardcoded
```

---

## The Monster Signature
A skill earns the title "monster" when:
- it triggers reliably because the description is excellent
- it produces consistent, high-quality output because the workflow is precise
- it never hallucinates because live data comes from tools
- it never goes rogue because side effects are gated
- anyone can maintain it because the structure is clear
- it improves over time because evals catch regressions
- it works on Haiku, Sonnet and Opus without changes
