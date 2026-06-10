# the-skill-skiller - The Skill Factory 🔨

A Claude Code skill that builds other skills. Smart interview, automated construction, real eval testing.
Everything runs in English: the interview, the generated skill, the name, and the command.

## Usage
```
/the-skill-skiller                                      <- full interview (3 + 2-3 questions)
/the-skill-skiller a skill that summarizes meeting transcripts   <- quick build from a raw idea
/the-skill-skiller automate competitor analysis          <- works with any rough phrasing
```

## What makes it a monster
- **Per-domain interview** - different smart questions for marketing / finance / legal / code...
- **Single-Focus Gate** - blocks a skill that tries to do 20 things, narrows it to one sharp task
- **Two-layer eval** - measures whether the skill *triggers* (trigger-rate + train/test split) AND whether it *works correctly* (real runs against pass criteria)
- **Collision detection** - checks that the new description does not clash with your installed skills
- **4-part accuracy contract** - prevents hallucinations: what it knows / does not know / when to ask / when to refuse
- **Dry-run** - shows you everything before writing to disk
- **Cross-OS** - detects Mac/Windows and adapts paths automatically
- **Packaging for sharing** - installs globally + creates a zip with install instructions to share with others

## Structure
| File | Role |
|---|---|
| `SKILL.md` | main orchestrator (6 steps) |
| `reference/interview-questions.md` | per-domain question bank |
| `reference/skill-blueprints.md` | 5 architectures + decision matrix |
| `reference/quality-manifesto.md` | the 10 monster rules + focus gate |
| `reference/eval-engine.md` | the two-layer eval engine |
| `reference/hallucination-contract.md` | hallucination prevention contract |
| `scripts/package-skill.{sh,ps1}` | cross-OS zip packaging |
| `templates/` | README + install prompt for every package |
| `evals/` | 3 quality checks for the skill itself |

## DNA
A blend of: creating-skills (Mendi Koritz) · the official skill-creator (Anthropic) · Custom GPT Architect (Jay).

---
Built for jaygptpro.
