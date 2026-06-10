# Interview Question Bank - Skill Architect

This file contains the per-domain deep-dive questions for round 2 of the interview.
Pick the 2-3 most relevant questions based on the round 1 answers.

---

## Universal questions (always relevant)
- **Output**: "What exactly comes out of the skill? A file? An analysis? JSON? A summary?"
- **Frequency**: "How many times per week / per day will someone run this skill?"
- **Success**: "How will you know the skill worked? What will look different in your work?"
- **Failure**: "What is the worst thing that could happen if the skill gives a wrong result?"
- **Input**: "What does the user feed the skill? Text? A file? A URL? A list?"

---

## Domain: Marketing, Content and Sales
- Does the skill need to know the Brand Voice? (if yes, add a reference file for brand rules)
- Which platforms? (LinkedIn? Email? Website? Social?)
- Is there an existing template people use that the skill must preserve?
- Does the skill create content from scratch or improve / repurpose existing content?
- Should it check competitors online before creating content? (then WebSearch)

## Domain: Product Development and R&D
- Does the skill work on code? On specs? On both?
- Which technologies are in use? (important for reference content)
- Does it need access to the repo? Jira? Notion?
- Who is the stakeholder receiving the output? PM? Engineer? Customer?
- Is approval required before any action? (then disable-model-invocation)

## Domain: Finance, Accounting and BI
- Does the skill read Excel / CSV / BigQuery / DB data?
- Does the skill's output influence material financial decisions? (then human-in-the-loop)
- Which metrics / KPIs matter most for the analysis?
- Is consistency with existing formats required (reports, templates)?
- Is there a compliance requirement the skill must respect?

## Domain: Operations and Admin
- Does the skill work on processes stored in a Wiki / Notion / Confluence?
- Does the skill create documents shared with external parties?
- Are there SLAs / deadlines the skill needs to account for?
- How many people are involved in the process the skill automates?
- Does the skill produce actions that require human approval? (then disable)

## Domain: Customer Support
- Does the skill send replies to customers directly? (then disable-model-invocation is mandatory)
- What tone is required? (formal / warm / technical / authoritative?)
- Is there an existing Knowledge Base the skill should rely on?
- What response time is expected?
- Are there inquiry categories with different answers?

## Domain: HR, Recruiting and People
- Does the skill see sensitive personal data? (then privacy boundaries are mandatory)
- Does the skill rank / reject candidates? (then a bias-prevention section is mandatory)
- Do the skill's outputs go through legal / compliance before use?
- Does the skill produce communication sent to candidates? (then disable)
- What is the structure of the Job Description / forms the organization already uses?

## Domain: Legal, Compliance and Regulation
- **Always include**: "For preliminary guidance only - not a substitute for professional legal advice"
- What document types? (NDA / SaaS / Employment / GDPR?)
- Does the skill highlight unusual clauses / risks?
- Does the output go through a lawyer before use? (then human-in-the-loop)
- Which jurisdiction? (US / EU / other?)

## Domain: Code, DevOps and Development
- Which language / framework / stack?
- Does the skill run code? (then Bash tool, sandboxing)
- Does the skill write to production code? (then disable for any commit / push)
- Is there a CI/CD setup the skill needs to be aware of?
- What output format is required? (PR description? Commit msg? Doc?)

---

## Signal Patterns - what the answers reveal

| Pattern in the answer | Architectural signal |
|---|---|
| "Sends results to external people" | `disable-model-invocation: true` |
| "Works with data that changes" | dynamic context injection (Blueprint 3) |
| "Lots of domain-specific knowledge" | reference file (Blueprint 2) |
| "Long / multi-step process" | split into explicit steps |
| "Several distinct responsibilities" | subagent architecture (Blueprint 4) |
| "Sensitive - could cause damage" | explicit boundaries + human gates |
| "Non-technical team" | simple UX, no jargon, clear argument-hint |
| "Technical team, DevOps" | Bash integration, scripts, Git tools |
