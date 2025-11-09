# Project Instructions - OpenCode

> **Note**: This is the main orchestrator file. For detailed guides, see `OpenCodeUsage/README.md`

---

## Project Purpose
[Fill in: What this project does - 1-2 sentences]

## Tech Stack
[Fill in: Technologies, frameworks, and languages used]
- Language:
- Framework:
- Key Libraries:
- Package Manager:

## Architecture Notes
[Fill in: Key architectural decisions, patterns, or structure]

---

## Essential Instructions (Always Follow)

### Core Behavior
- Do what has been asked; nothing more, nothing less
- NEVER create files unless absolutely necessary for achieving your goal
- ALWAYS prefer editing existing files to creating new ones
- NEVER proactively create documentation files (*.md) or README files unless explicitly requested

### Naming Conventions
- **Directories**: Use CamelCase (e.g., `VideoProcessor`, `AudioTools`, `DataAnalysis`)
- **Date-based paths**: Use skewer-case with YYYY-MM-DD (e.g., `logs-2025-01-15`, `backup-2025-12-31`)
- **No spaces or underscores** in directory names (except date-based paths)

### TODO Management
- **Always check `TODOS.md` first** when starting a task or session
- **Update immediately** when tasks are completed, added, or changed
- Keep the list current and manageable

### Git Workflow Essentials

**After completing major changes, you MUST commit your work.**

**Conventional Commits Format:**
```bash
<type>: <brief description>

<optional body>

🤖 Generated with [OpenCode](https://opencode.ai)

Co-Authored-By: OpenCode <noreply@opencode.ai>
```

**Common Types:** `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`

**Examples:**
```bash
feat: Add user authentication
fix: Correct timezone bug
docs: Update README
```

**For complete details:** See `OpenCodeUsage/git_guide.md`

---

## When to Read Specific Guides

**Read the full guide in `OpenCodeUsage/` when you encounter these situations:**

### Secrets & API Keys
- **When managing API keys or secrets** → Read `OpenCodeUsage/secrets_management.md`
- **Before implementing secrets loading** → Read `OpenCodeUsage/secrets_management.md`

### Package Management
- **When using UV package manager** → Read `OpenCodeUsage/uv_usage.md`
- **Before creating pyproject.toml** → Read `OpenCodeUsage/uv_usage.md`
- **When managing Python dependencies** → Read `OpenCodeUsage/uv_usage.md`

### Version Control
- **Before making a git commit** → Read `OpenCodeUsage/git_guide.md`
- **When initializing a new repo** → Read `OpenCodeUsage/git_guide.md`
- **For git workflow and branching** → Read `OpenCodeUsage/git_guide.md`
- **For conventional commits reference** → Read `OpenCodeUsage/git_guide.md`

### Database Management
- **When working with databases** → Read `OpenCodeUsage/db_usage.md`
- **Before implementing data persistence** → Read `OpenCodeUsage/db_usage.md`
- **For database.py template** → Read `OpenCodeUsage/db_usage.md`

### Search & Research
- **When searching across 20+ files** → Read `OpenCodeUsage/opencode_agents.md`
- **When finding patterns in codebase** → Read `OpenCodeUsage/opencode_agents.md`
- **When locating TODOs/FIXMEs** → Read `OpenCodeUsage/opencode_agents.md`

### Testing
- **Before writing tests** → Read `OpenCodeUsage/testing_strategies.md`
- **When implementing test coverage** → Read `OpenCodeUsage/testing_strategies.md`
- **For test organization** → Read `OpenCodeUsage/testing_strategies.md`

### Code Quality
- **When refactoring code** → Read `OpenCodeUsage/code_style_guide.md`
- **Before major code changes** → Read `OpenCodeUsage/code_style_guide.md`
- **For style guidelines** → Read `OpenCodeUsage/code_style_guide.md`

### Project Setup
- **When starting a new project** → Read `OpenCodeUsage/project_setup.md`
- **For directory structure** → Read `OpenCodeUsage/project_setup.md`
- **Setting up CI/CD** → Read `OpenCodeUsage/project_setup.md`

---

## Quick Reference

### Security Basics
- Store API keys in `secrets.json` (NEVER commit)
- Add `secrets.json` to `.gitignore` immediately
- Provide `secrets_template.json` for setup
- Use environment variables as fallbacks

### OpenCode Agents Quick Trigger
**When searching 20+ files**, use @research for:
- Finding patterns across codebase
- Searching TODO/FIXME comments
- Locating API endpoints or functions
- Documentation searches

**When analyzing git changes**, use @git for:
- Reviewing large diffs (100+ lines)
- Commit history analysis
- Branch comparisons
- Merge conflict assessment

**When running commands**, use @bash for:
- Build processes
- Test suites
- Deployments
- Multi-step command sequences

---

## Code Style Guidelines

### Function & Variable Naming
- Use meaningful, descriptive names
- Keep functions small and focused on single responsibilities
- Add docstrings to functions and classes

### Error Handling
- Use try/except blocks gracefully
- Provide helpful error messages
- Never let errors fail silently

### File Organization
- Group related functionality into modules
- Use consistent import ordering:
  1. Standard library
  2. Third-party packages
  3. Local imports
- Keep configuration separate from logic

---

## Communication Style
- Be concise but thorough
- Explain reasoning for significant decisions
- Ask for clarification when requirements are ambiguous
- Proactively suggest improvements when appropriate

---

## Complete Guide Index
For all detailed guides, workflows, and examples, see:
**`OpenCodeUsage/README.md`** - Master index of all documentation

---

*Last updated: 2025-11-09*
*Model: OpenCode Optimized*