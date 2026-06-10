# Eval 2: Realistic - Full Interview with Side Effects

## Input
The user runs: `/the-skill-skiller` (empty), and the interview reveals they want a skill that sends emails
to customers after a sales call, for a non-technical team, using live CRM data.

## Expected Output
- Full interview (3 round-1 questions, then 2-3 round-2 questions from the customer support / marketing domains)
- Identifies two critical requirements: sending emails (a side effect) + live CRM data
- Picks Blueprint 3 (dynamic injection) or 5, and sets `disable-model-invocation: true`
- Injects an accuracy contract that requires fetching CRM data from a tool, never from memory
- Simple UX because the team is non-technical (clear argument-hint, no jargon)

## Pass Criteria
- [ ] Ran the full interview, not a quick build
- [ ] Set `disable-model-invocation: true` because of email sending
- [ ] The accuracy contract requires fetching CRM data from a tool
- [ ] Chose an architecture suited to live data (Blueprint 3 or 5)
- [ ] The boundaries section forbids automatic sending without human approval
- [ ] Layer B of the eval tested output quality, not just the trigger-rate
