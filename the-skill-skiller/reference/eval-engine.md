# The Eval Engine - Testing a Skill Before Release

This is what separates this skill from every other skill builder.
A skill is not "ready" until it has passed both layers here.

Read this file in Step 6 (Eval), after the dry-run is approved and before packaging.

---

## Why eval at all

A skill has a unique problem: it only runs if Claude **chooses** it, and Claude chooses based on
a single field - the `description`. You can write a perfect skill that simply never triggers because
the description is weak, or because it collides with an existing skill. The eval catches this before release.

There are two separate questions, and each layer answers one:
- **Layer A (Trigger)**: does the skill even fire when it should?
- **Layer B (Quality)**: when it fires, does it do the job *correctly*?

---

## Layer A - Trigger-Rate with Train/Test Split

### Step 1 - Build 10 trigger sentences
Write 10 different ways a real user would ask for this skill.
Vary them: direct ("analyze competitors"), indirect ("who are we up against in the market"), with context ("compare us to Wix").
**Important**: also include 3 distractor sentences - similar requests the skill should **not** trigger on.

### Step 2 - Split Train/Test (this is the clever trick)
- **Train (6 sentences)**: used to improve the description.
- **Test (4 sentences)**: kept aside. The final check runs only on these.

Why split? If you improve and test on the same sentences, it is easy to "cheat" (like a student who gets
the exam in advance). The split ensures the description is genuinely general and good, not memorized.

### Step 3 - Run the check through a "naive" subagent
For each sentence, launch a subagent (the subagent / Task tool) that receives **only** the new skill's description
plus the list of the other skills, and ask:

> "A user wrote: '[sentence]'. From the following skills, which would you choose (if any)?
> Return only the skill name, or 'none'."

The subagent must be naive - do not tell it the correct answer.
Score: on trigger sentences, correct if it chose the new skill. On distractor sentences, correct if it did not.

### Step 4 - Compute the trigger-rate
`trigger-rate = (correct answers / total sentences) x 100`
Pass threshold: on the 4-sentence Test set, **all 4 must be correct** (a single miss fails and triggers the improvement loop). With only 4 items the possible scores are 0/25/50/75/100, so "high enough" means 4/4, not an 80% that cannot occur. If you want a softer bar, widen the split to more test sentences first.

---

## The Improvement Loop (Multiple Description Candidates)

If any test sentence misses (not 4/4), do not rewrite one description and hope. Do this:

1. Generate **3 alternative description drafts**, each emphasizing a different angle
   (different verbs, different trigger phrases, different WHEN phrasing).
2. Run Layer A (on the Train set) for each of the 3 candidates.
3. Pick the candidate with the highest score.
4. Run it once on the Test set for final confirmation.
5. If still not 4/4 after 2 rounds, stop and present to the user for a manual decision (do not get stuck in an infinite loop).

**"Just test" mode**: if the user asked not to auto-fix, skip the loop,
simply show the score and what failed, and let them decide.

---

## Collision Detection

This is the problem no other skill builder handles. If the new description overlaps with a skill
already installed on the user's machine, **both** suffer and Claude gets confused about which to pick.

### How to run it
1. List the installed skills and their descriptions:
   - Mac/Linux: `ls ~/.claude/skills/` then read each `SKILL.md` (the description line in the frontmatter)
   - Windows: `Get-ChildItem $env:USERPROFILE\.claude\skills\` and the same
2. Run the new skill's 10 trigger sentences through a subagent that sees **the new skill + all existing skills**.
3. If, on a sentence that should trigger the new skill, the subagent picks an existing skill instead,
   **a collision is detected**.

### What to do with a collision
Warn the user explicitly:
> "⚠️ I detected an overlap: on '[sentence]' Claude may pick `[existing-skill]` instead of the new skill.
> Options: (a) sharpen the description to be more unique, (b) narrow the new skill to something tighter, (c) proceed anyway."

Default: automatically try to sharpen the description once, and if the overlap remains, present it to the user.

---

## Layer B - Output Quality

The trigger-rate only checks *whether the skill fires*. But a skill can fire and do a bad job.
Layer B tests the deliverable itself.

### How to run it
For each of the new skill's 3 eval files (basic / realistic / edge):
1. Launch a subagent that receives **the new skill's full SKILL.md** + the eval's `Input`.
2. Let it actually produce the output, as if the skill was invoked.
3. Launch a second subagent (a judge) that compares the output against that eval's `Pass Criteria` and returns:
   ```json
   { "eval": "basic", "passed": true|false, "failed_criteria": [], "notes": "..." }
   ```

### Pass threshold
- **basic + realistic**: must pass (passed: true).
- **edge**: should pass; if it fails, log a warning in the delivery report, not a blocker.

If basic or realistic fails, go back to SKILL.md, fix the relevant step/rule, and run again.

---

## Engine Flow Summary

```
Layer A (Trigger)
  ├─ 10 sentences (including 3 distractors) -> split 6 train / 4 test
  ├─ a naive subagent measures trigger-rate on test
  ├─ if not 4/4: 3 description candidates -> pick the winner -> test again (max 2 rounds)
  └─ collision detection against installed skills

Layer B (Quality)
  ├─ run each eval through a subagent -> get real output
  ├─ a judge subagent scores against Pass Criteria
  └─ basic+realistic must pass, edge = warning

-> Both layers passed? The skill is ready for packaging and the delivery report.
```

> All the scores (trigger-rate, Layer B results, collisions) go into the final delivery report,
> so the user sees in numbers why their skill is ready.
