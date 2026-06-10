# The Hallucination Prevention Contract - 4 Parts

Origin of the idea: Custom GPT Architect. Instead of *hoping* the model will not invent information,
you define an explicit four-part contract inside the skill. Inject a block like this into every skill you build
that could state facts, numbers, or information that changes over time.

---

## Why this is architecture, not hope
A language model will always prefer giving an answer over saying "I don't know". That is its default.
The contract turns "don't make things up" from a polite request into a built-in rule: you define upfront what
the skill knows, what it does not, when to ask, and when to refuse. This dramatically reduces hallucination risk.

---

## The Four Parts

### Part 1 - What the skill knows (Known)
The sources of truth the skill is allowed to rely on:
- stable general knowledge that does not change (definitions, concepts, methodologies)
- content the user supplied in the current input
- reference files inside the skill

### Part 2 - What the skill does not know (Unknown -> requires a tool)
Anything that changes over time or is specific to the moment - **never invent, always fetch from a tool**:
- prices, numbers, statistics, market sizes
- competitor data, current market conditions
- dates, events, news
- live system state (git, DB, API)
-> If no tool can fetch it, the skill says "I don't have access to that data", it does not invent.

### Part 3 - When to ask (Ask)
The skill stops and asks the user when:
- a critical detail is missing and without it the output would be a guess
- there are several reasonable interpretations of the request
- an irreversible action is about to happen and approval is needed

### Part 4 - When to refuse (Refuse)
The skill refuses (politely, with an explanation) when:
- it is asked to state a fact it has no way to verify
- the request is outside its defined boundaries
- the answer would require inventing sensitive information (legal / medical / financial) without a source

---

## The Block Template to Inject into the Built Skill

```markdown
## Accuracy Contract
**Knows**: [stable knowledge + user input + reference files]
**Does not know (requires a tool)**: [list of changing data] -> fetch via [WebSearch/Read/API], never invent.
**Asks when**: [conditions for stopping and asking]
**Refuses when**: [conditions for a polite refusal]
```

Fill the template with the specifics of the skill being built - never leave it generic.

---

## Full Example (a competitor analysis skill)

```markdown
## Accuracy Contract
**Knows**: competitive analysis frameworks, battle card structure, the input the user gave about their product.
**Does not know (requires a tool)**: competitor prices, current features, market shares, reviews ->
  fetch via WebSearch/WebFetch at runtime. Never write a number from memory.
**Asks when**: the user did not specify who the competitors are, or what the exact market is.
**Refuses when**: asked to forecast a private competitor's revenue (no reliable source) ->
  explain that only a range estimate with a disclaimer is possible.
```
