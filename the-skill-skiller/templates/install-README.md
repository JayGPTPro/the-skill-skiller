# Installing the Skill: {{SKILL_NAME}}

This skill was built with **the-skill-skiller**. Installation takes one minute.

## The Easy Way (Recommended) - Let Claude Install It

1. Extract the zip file. You will get a folder named `{{SKILL_NAME}}`.
2. Drag the folder into any project folder where Claude Code is open.
3. Paste the following prompt to Claude (also found in `install-prompt.txt`):

```
I added a skill named {{SKILL_NAME}} to this folder. Install it into my global skills
(in the home directory: ~/.claude/skills/ on Mac/Linux, or %USERPROFILE%\.claude\skills\ on Windows,
not inside this project). After copying, delete the folder from the project and tell me when it's done.
```

4. That's it. Run `/{{SKILL_NAME}}` in any project.

## The Manual Way

1. Open your home directory and find the hidden `.claude` folder
   (Mac: press `Cmd+Shift+.` in Finder to show hidden files. Windows: File Explorer > View > Hidden items).
2. Inside it, open the `skills` folder. No `skills` folder? Create one.
3. Copy the `{{SKILL_NAME}}` folder in there:
   - **Mac / Linux**: `~/.claude/skills/{{SKILL_NAME}}/`
   - **Windows**: `%USERPROFILE%\.claude\skills\{{SKILL_NAME}}\`
4. Restart Claude Code.

## Verify It Works
Open a new Claude Code session and type `/{{SKILL_NAME}}`. If it appears in the list, it is installed.

---
Built with the-skill-skiller · jaygptpro
