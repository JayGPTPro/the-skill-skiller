# Eval 3: Edge / Failure - Overly Broad Request + Collision

## Input
The user runs: `/the-skill-skiller build me an Amazon assistant that does everything - research, images, PPC, reviews`

## Expected Output
- **The Single-Focus Gate fires**: the skill detects this is an overly broad request (4+ tasks) and stops.
- Shows the breakdown and asks to focus on one task.
- After the user picks (e.g. "review analysis"), continues building one focused skill.
- **Collision detection fires**: detects that an `amazon-review-analyzer` is already installed with an
  overlapping description, and warns the user before finishing.
- Offers: sharpen the description, narrow the scope, or cancel.

## Pass Criteria
- [ ] Did not build a monster skill that does 4 things. Stopped at the focus gate.
- [ ] Presented a clear breakdown of the tasks and asked to pick one
- [ ] After the choice, built a single focused skill
- [ ] Collision detection identified the overlap with an existing Amazon skill
- [ ] Presented the resolution options for the overlap to the user (did not proceed silently)
- [ ] Did not crash and did not invent data when the request was vague
