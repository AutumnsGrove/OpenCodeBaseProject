# OpenCode Agents Guide

Complete guide to using OpenCode sub-agents for context-efficient workflows.

---

## Overview

OpenCode agents are specialized sub-agents that run heavy operations in separate context windows, keeping your main conversation clean and focused.

### The Six OpenCode Agents

1. **@research** - File and documentation search specialist
2. **@git** - Git diff and commit analysis specialist
3. **@bash** - Command execution and output parsing specialist
4. **@mcp** - MCP tool configuration and documentation specialist
5. **@coder** - Small code patch execution specialist
6. **@planner** - Task orchestration and planning specialist

---

## The Problem They Solve

When working on complex tasks, your context window fills up with:
- Verbose search results from 100+ files
- Long API documentation pages
- npm install logs and build output
- Git diffs with thousands of lines
- Accumulated conversation history

**Result:** Reduced effectiveness and wasted tokens.

### The Solution

Agents run in separate context windows, perform specialized tasks, and return **condensed results** to your main conversation.

**Measured Token Savings:**
- **@research**: 70,100 tokens processed → 3,246 returned (95.4% savings)
- **@git**: 42,900 tokens processed → ~500 returned (98.8% savings)
- **@bash**: 20,600 tokens processed → ~700 returned (96.6% savings)
- **@mcp**: 53,300 tokens processed → ~540 returned (99.0% savings)

**Total**: 187,000 tokens quarantined, ~5,000 added to main context

---

## Quick Start

### Testing Your Installation

After setting up OpenCode agents, test each one:

**1. Test @research:**
```
@research find all TODO comments in the codebase
```
Expected: Condensed list of TODOs with file:line references

**2. Test @bash:**
```
@bash check the current git status
```
Expected: Summary of git status (not raw output)

**3. Test @git:**
```
@git review my current git diff
```
Expected: Condensed summary of changes (not raw diff)

**4. Test @mcp:**
```
@mcp help me configure the Context7 MCP server
```
Expected: Minimal config with usage instructions

**5. Test @coder:**
```
@coder add a console.log statement at the start of the main function
```
Expected: Condensed summary with code snippet

**6. Test @planner:**
```
@planner create a plan for adding input validation to our forms
```
Expected: Execution plan with task breakdown

**7. Check agents are loaded:**
```
List all available sub-agents
```
Expected: Should show all six agents

---

## Agent Details

### @research - Search Specialist

**Use For:**
- Searching large codebases (20+ files)
- Finding patterns across multiple files
- Extracting info from documentation
- Locating TODO comments, deprecated APIs, security issues

**Example Invocations:**
```
@research find all React components using useEffect
@research search for all API endpoints
@research find all TODO comments in the backend
@research locate all authentication functions
```

**What It Returns:**
```
## Search Results: React components with useEffect

### Summary
Found 12 components using useEffect across 8 files

### Key Findings

**1. Data Fetching Pattern**
- Location: `src/components/UserProfile.jsx:45`
- Pattern: useEffect with fetch API
- Relevance: Could use React Query instead

**2. Event Listeners**
- Location: `src/components/Dashboard.jsx:78`
- Pattern: useEffect with addEventListener
- Relevance: Missing cleanup function

### Recommended Actions
- Review data fetching patterns for React Query migration
- Add cleanup functions to event listeners
```

---

### @git - Git Analysis Specialist

**Use For:**
- Reviewing large diffs (100+ line changes)
- Branch comparison before merging
- Commit history analysis
- Merge conflict identification
- Change impact assessment

**Example Invocations:**
```
@git review my staged changes
@git compare feature-branch with main
@git analyze the last 10 commits
@git find commits that modified auth module
```

**What It Returns:**
```
## Git Analysis: Review staged changes

### Status
📊 Summary: 5 files changed, 234 insertions(+), 45 deletions(-)

### Key Changes by Impact

**🔴 CRITICAL (Review Carefully)**
- `src/auth/login.js:45-78` - Modified authentication logic
- `config/database.js:12` - Changed DB connection string
- Relevance: Security-sensitive changes

**🟡 MEDIUM (Notable Changes)**
- `api/users.js:102-145` - Refactored user endpoint
- `tests/auth.test.js:89` - Updated test assertions
- Relevance: Core functionality modifications

**🟢 MINOR (Low Risk)**
- `styles/main.css:234` - Updated button styling
- `README.md:45` - Fixed typo
- Relevance: Non-functional changes

### Changes by File Type
- Source Code: 3 files
- Tests: 1 file
- Config: 1 file

### Recommendations
- Review authentication changes carefully
- Ensure database config uses environment variables
- Run full test suite before merging
```

---

### @bash - Command Execution Specialist

**Use For:**
- Running build commands
- Executing test suites
- Running deployment scripts
- Multi-step command sequences

**Example Invocations:**
```
@bash run npm test and analyze any failures
@bash run the build and check for warnings
@bash execute the deployment script
@bash install dependencies and run tests
```

**What It Returns:**
```
## Execution Results: npm test

### Status
❌ Failed (3 tests passed, 2 failed)

### Summary
Test suite completed with 2 failures in authentication module

### Commands Executed
1. `npm install` - Success
2. `npm test` - Failed

### Errors Found

**Error 1: Authentication Test Failure**
```
FAIL tests/auth.test.js
  ● Login with invalid credentials

    expect(received).toBe(expected)
    Expected: 401
    Received: 200
```
**Likely Cause**: Auth middleware not properly rejecting invalid tokens
**Suggested Fix**: Check token validation logic in auth middleware

**Error 2: Database Connection**
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```
**Likely Cause**: Database not running
**Suggested Fix**: Start PostgreSQL service

### Next Steps
1. Fix auth middleware token validation
2. Start database service
3. Re-run tests
```

---

### @mcp - MCP Configuration Specialist

**Use For:**
- Configuring MCP servers (Context7, Notion, Puppeteer, etc.)
- Reading verbose API documentation
- Generating minimal working configs
- Understanding tool integration requirements

**Example Invocations:**
```
@mcp help me configure the Context7 MCP server
@mcp how do I set up the SQLite MCP server?
@mcp generate a minimal config for Puppeteer
```

**What It Returns:**
```
## MCP Configuration: Context7

### Quick Start
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["@upstash/context7-mcp"]
    }
  }
}
```

### Prerequisites
- Node.js installed
- npm or npx available

### Usage Example
```
# Context7 will automatically fetch documentation
# for libraries when you ask about them
```

### Critical Gotchas
⚠️ **Requires internet connection** to fetch documentation

### Next Steps
1. Add config to your opencode.json
2. Restart OpenCode
3. Ask about any library documentation
```

---

### @coder - Code Patch Specialist

**Use For:**
- Implementing small code changes (0-250 lines)
- Fixing import errors and dependencies
- Implementing TODO/FIXME comments
- Applying small bug fixes and patches

**Example Invocations:**
```
@coder fix the import error in utils.py
@coder implement the TODO in the authentication module
@coder add error handling to the login function
@coder refactor the duplicate code in these three files
```

**What It Returns:**
```
## Code Implementation: Fix import errors

### Changes Made

**File: `src/utils/data.py`**
- **Lines 3-5**: Fixed import statements
- **Before**: `import json, os, sys`
- **After**: 
  ```python
  import json
  import os
  import sys
  ```
- **Reason**: PEP 8 compliance

**File: `src/auth/login.py`**
- **Lines 12**: Added missing import
- **Added**: `from datetime import datetime, timedelta`
- **Reason**: Required for token expiration

### Verification
✅ Imports resolved: All modules import successfully
✅ Linting: No issues
✅ Tests: 15/15 passed

### Token Savings
- Full implementation in main: 3,200 tokens
- Coder agent summary: 800 tokens
- **Savings: 75% context reduction**

### Follow-up Actions
- [ ] Review import organization
- [ ] Consider adding import sorting hook
```

---

### @planner - Task Orchestration Specialist

**Use For:**
- Planning complex multi-file changes (3+ files)
- Analyzing ambiguous requirements
- Creating execution plans for new features
- Orchestrating large refactoring efforts

**Example Invocations:**
```
@planner plan a JWT authentication system
@planner create a plan for refactoring the API layer to async/await
@planner plan the implementation of a new export feature
```

**What It Returns:**
```
## Execution Plan: JWT Authentication System

### Overview
Implement JWT-based authentication with login, logout, and token refresh

### Tasks (Total: 6 tasks)

#### Task 1: Research existing auth patterns
- **Agent**: @research
- **Complexity**: Low
- **Description**: Find existing authentication code and patterns
- **Dependencies**: None

#### Task 2: Design token structure
- **Agent**: @planner (continues)
- **Complexity**: Medium
- **Description**: Define JWT payload structure and expiration
- **Dependencies**: Task 1

#### Task 3: Implement login endpoint
- **Agent**: @coder
- **Complexity**: Medium
- **Files**: `api/auth.py`, `models/user.py`
- **Description**: Create login endpoint that returns JWT
- **Dependencies**: Task 2

#### Task 4: Add authentication middleware
- **Agent**: @coder
- **Complexity**: High
- **Files**: `middleware/auth.py`
- **Description**: Create middleware to verify JWT on protected routes
- **Dependencies**: Task 3

#### Task 5: Implement token refresh
- **Agent**: @coder
- **Complexity**: Medium
- **Files**: `api/auth.py`
- **Description**: Add token refresh endpoint
- **Dependencies**: Task 4

#### Task 6: Write tests
- **Agent**: @bash (run tests)
- **Complexity**: Medium
- **Files**: `tests/test_auth.py`
- **Description**: Create comprehensive tests
- **Dependencies**: Task 5

### Execution Order
```
Task 1 → Task 2 → Task 3 → Task 4 → Task 5 → Task 6
```

### Risk Assessment

**🔴 High Risk:**
- Token security: Use strong secret key, consider rotation
- Token theft: Implement HTTPS only, httpOnly cookies

**🟡 Medium Risk:**
- Token expiration: Balance security vs UX
- Database load: Token validation on each request

### Recommendations
- Use environment variable for JWT secret
- Implement token blacklist for logout
- Add rate limiting to auth endpoints
- Consider refresh token rotation
```

---

## When to Use Agents

### ✅ Use Agents For

- **Large codebases** (100+ files)
- **Verbose documentation** (10+ pages)
- **Long command output** (npm install, test runs)
- **Multi-step workflows** (search → configure → execute)
- **When hitting context limits** (conversation getting sluggish)
- **Git diffs** (100+ lines changed)
- **Complex planning** (3+ files affected)

### ❌ Use Main OpenCode For

- **Simple tasks** (single file edits)
- **Small codebases** (<20 files)
- **Interactive debugging** (tight feedback loops)
- **Quick commands** (ls, git status)
- **Learning/exploration** (when you want full context)
- **Architectural decisions** (main conversation context needed)

---

## Agent Architecture

```
Main OpenCode Session
├── Clean context
├── Focus on orchestration
└── Receives condensed results from:
    │
    ├─→ @research (separate context)
    │   ├── Searches 70k+ tokens across 10+ files
    │   └── Returns 3k token summary (95% savings)
    │
    ├─→ @git (separate context)
    │   ├── Analyzes 43k token diff
    │   └── Returns 500 token summary (98% savings)
    │
    ├─→ @bash (separate context)
    │   ├── Processes 21k+ tokens of command output
    │   └── Returns 700 token summary (97% savings)
    │
    ├─→ @mcp (separate context)
    │   ├── Reads 53k+ tokens of documentation
    │   └── Returns 540 token summary (99% savings)
    │
    ├─→ @coder (separate context)
    │   ├── Implements 8k+ tokens of code
    │   └── Returns 1.2k token summary (85% savings)
    │
    └─→ @planner (separate context)
        ├── Analyzes complex requirements
        └── Returns execution plan (75% savings)

Heavy operations happen in agent contexts, not yours.
```

---

## Best Practices

### Invoke Explicitly

```
✅ "@research find all components using useEffect"
❌ "Find all components" (main might search inefficiently)
```

### Combine Agents for Complex Tasks

```
"@research find all API endpoints, then @bash run integration tests"
```

### Let Agents Do Their Job

```
✅ "@research analyze the auth system"
❌ "@research read auth.js" (too specific, just use Read tool)
```

### Check Agent Responses

Agents are focused on their specialty - review their findings before implementing changes.

---

## Customization

Agent files are in `.opencode/agents/` directory. Each file has:

**1. Frontmatter (metadata):**
```yaml
---
description: "When to use this agent"
mode: subagent
model: anthropic/claude-haiku-4-20250514
tools:
  read: true
  grep: true
---
```

**2. System Prompt (instructions):**
```
You are the Research Agent...
[detailed instructions]
```

Edit these files to customize:
- Which tools each agent can access
- The agent's behavior and output format
- When the agent should be invoked

---

## Project vs User Level

**Project-level** (`.opencode/agents/` in project):
- Available only in this project
- Project-specific customizations
- Committed to git

**User-level** (`~/.opencode/agents/`):
- Available in ALL your projects
- Personal preferences
- Not in version control

OpenCode loads both, with project-level taking precedence.

---

## Troubleshooting

### Agents not showing up?

```bash
# Check project-level agents
ls .opencode/agents/

# Check user-level agents
ls ~/.opencode/agents/

# Verify opencode.json config
opencode agent list
```

### Agent errors?

- Check agent file syntax (valid YAML frontmatter)
- Verify tool names match OpenCode capabilities
- Check model names are valid

### Agent not invoked automatically?

OpenCode agents are invoked:
1. **Manually** by @ mentioning them
2. **Automatically** by main OpenCode based on descriptions

Make sure your description is clear and specific.

---

## Related Guides

- **[git_guide.md](./git_guide.md)** - Git workflows and conventions
- **[project_setup.md](./project_setup.md)** - Setting up OpenCode projects
- **[secrets_management.md](./secrets_management.md)** - Handling secrets

---

*Model: Kimi K2 (build), Claude Sonnet 4.5 (plan)*
*Last updated: 2025-11-09*