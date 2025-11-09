# OpenCode BaseProject

A comprehensive project template with built-in OpenCode workflows, best practices, and extensive documentation for rapid development setup.

**What you get:** Git hooks • Multi-language support • Security defaults • 17 comprehensive guides • OpenCode-optimized agents

---

## 🚀 Quick Start

### Option 1: New Project Setup

**Magic One-Liner in OpenCode:**
```
Clone https://github.com/AutumnsGrove/BaseProject (main branch) to /tmp, copy to ~/Projects/[ASK ME PROJECT NAME] excluding (.git/), rename OPENCODE.md sections (Project Purpose, Tech Stack, Architecture Notes) and README.md (title, description, features) with my project details [ASK ME: name, description, tech stack, API keys needed], init language-specific dependencies (uv init for Python creates pyproject.toml, npm init for JS creates package.json, go mod init for Go creates go.mod), create proper directory structure (src/ with __init__.py or index.js, tests/ with __init__.py), generate secrets_template.json with my API key placeholders, write TODOS.md with 3-5 initial tasks derived from project description, git init with user.name and user.email from global git config, ask if I want to install git hooks [ASK ME: Install git hooks for code quality and security? Recommended: yes], if yes then run ./OpenCodeUsage/pre_commit_hooks/install_hooks.sh (auto-detects from pyproject.toml/package.json/go.mod created above, installs language-appropriate hooks), make initial commit "feat: initialize [PROJECT] from OpenCode BaseProject template", display project summary and next steps including reminder about installed hooks
```

**Simple One-liner:**
```bash
bash setup.sh new
```

Or manually:
```bash
git clone https://github.com/AutumnsGrove/BaseProject.git /tmp/opencode-base
cp -r /tmp/opencode-base/* ~/Projects/MyNewProject/
cd ~/Projects/MyNewProject
bash setup.sh new
```

**What happens:**
- Creates OPENCODE.md with project instructions
- Sets up OpenCodeUsage/ guides (17 comprehensive docs)
- Creates .opencode/agents/ (6 specialized agents)
- Generates opencode.json configuration
- Initializes git with proper configuration
- Installs git hooks (code quality & security)
- Creates secrets_template.json for API keys
- Generates TODOS.md with initial tasks
- Makes initial commit following conventional commits

### Option 2: Add to Existing Project

**Magic One-Liner in OpenCode:**
```
Clone https://github.com/AutumnsGrove/BaseProject (main branch) to /tmp/bp, analyze my project: read existing README.md/OPENCODE.md, scan git history for commit patterns, detect tech stack and package managers, identify project architecture (monorepo/single package/etc), read TODOS.md if exists, copy OpenCodeUsage/ to my project (preserve any existing OpenCodeUsage/ files, only add new guides), intelligently merge OPENCODE.md: if exists parse sections and merge BaseProject sections using markers like "<!-- BaseProject: Git Workflow -->", if new create from template with detected project details, enhance .gitignore by merging entries (preserve existing, add missing), analyze commit messages and suggest adopting BaseProject style if inconsistent, check if using branches like dev/main and suggest workflow if not, ask if I want to install git hooks [ASK ME: Install git hooks for code quality and security? They auto-detect your language], if yes run ./OpenCodeUsage/pre_commit_hooks/install_hooks.sh interactively (installs appropriate hooks based on detected tech stack, backs up any existing hooks first), generate/update TODOS.md with project-aware tasks, create integration-summary.md report showing what was added/merged/skipped, backup modified files to ./.baseproject-backup-[TIMESTAMP]/, cleanup temp directory, display next steps
```

**Simple One-liner:**
```bash
bash setup.sh add
```

Or manually:
```bash
git clone https://github.com/AutumnsGrove/BaseProject.git /tmp/opencode-base
cd /path/to/your/project
cp -r /tmp/opencode-base/OpenCodeUsage ./
cp -r /tmp/opencode-base/.opencode ./
cp /tmp/opencode-base/opencode.json ./
cp /tmp/opencode-base/setup.sh ./
bash setup.sh add
```

**What happens:**
- Intelligently merges OPENCODE.md (preserves your content)
- Appends to .gitignore (doesn't overwrite)
- Adds OpenCodeUsage/ guides
- Sets up .opencode/agents/
- Creates opencode.json
- Optionally installs git hooks
- Backs up modified files
- Generates integration summary

---

## 📁 What's Included

```
BaseProject/
├── OPENCODE.md                   # Main project instructions file
├── OpenCodeUsage/                # Comprehensive workflow guides
│   ├── README.md                 # Guide index
│   ├── git_guide.md              # Git workflows and conventional commits
│   ├── opencode_agents.md        # OpenCode sub-agent usage patterns
│   ├── secrets_management.md     # API key handling and security
│   ├── uv_usage.md               # Python UV package manager
│   ├── testing_strategies.md     # Test patterns and frameworks
│   ├── code_style_guide.md       # Code quality principles
│   ├── project_setup.md          # Project initialization
│   ├── docker_guide.md           # Containerization
│   ├── ci_cd_patterns.md         # GitHub Actions
│   ├── pre_commit_hooks/         # Git hooks for code quality
│   └── templates/                # Template files
├── .opencode/agents/             # Specialized sub-agents
│   ├── research.md               # Codebase search specialist
│   ├── git.md                    # Git analysis specialist
│   ├── bash.md                   # Command execution specialist
│   ├── mcp.md                    # MCP configuration specialist
│   ├── coder.md                  # Code patch specialist
│   └── planner.md                # Task orchestration specialist
├── opencode.json                 # OpenCode configuration
├── setup.sh                      # Setup script
└── .gitignore                    # Comprehensive gitignore
```

---

## 🏠 OpenCode Agents

Specialized sub-agents for context-efficient workflows. Keep your main conversation clean while delegating heavy operations.

### The Six Agents

1. **@research** - File and documentation search specialist
2. **@git** - Git diff and commit analysis specialist
3. **@bash** - Command execution and output parsing specialist
4. **@mcp** - MCP tool configuration and documentation specialist
5. **@coder** - Small code patch execution specialist
6. **@planner** - Task orchestration and planning specialist

### Token Savings

**Measured in production:**
- **@research**: 70,100 tokens → 3,246 returned (95.4% savings)
- **@git**: 42,900 tokens → ~500 returned (98.8% savings)
- **@bash**: 20,600 tokens → ~700 returned (96.6% savings)
- **@mcp**: 53,300 tokens → ~540 returned (99.0% savings)

**Total**: 187,000 tokens quarantined, ~5,000 added to main context

### Quick Test

```bash
# Test @research
@research find all TODO comments in the codebase

# Test @git
@git review my current git diff

# Test @bash
@bash run npm test and analyze failures

# Test @mcp
@mcp help configure Context7 MCP server

# Test @coder
@coder fix the import error in utils.py

# Test @planner
@planner plan a JWT authentication system
```

---

## 🎯 What You Get

### Instant Best Practices

- **Git workflow patterns** - Conventional commits, unified git guide
- **Security by default** - API key management, secrets scanning hooks
- **Code quality hooks** - 8 production-ready git hooks for Python, JS, Go
  - `pre-commit-secrets-scanner` - Prevents committing API keys (15+ patterns)
  - Language-specific formatters (Black, Prettier, gofmt)
  - Test runner (blocks push if tests fail)
  - Dependency auto-updater
- **Testing strategies** - Unit, integration, and E2E test patterns
- **CI/CD templates** - GitHub Actions workflows
- **Documentation standards** - Consistent, scannable docs

### OpenCode-Optimized Workflows

- **Specialized agents** - @research, @git, @bash, @mcp, @coder, @planner
- **Context management** - Token-efficient operations
- **TODO management** - Task tracking integrated into workflow
- **Sub-agent patterns** - Breaking down complex tasks

### Multi-Language Support

Guides and patterns for:
- Python (with UV package manager)
- JavaScript/TypeScript
- Go
- Rust
- Docker containerization

---

## 📚 Documentation Structure

All guides follow a consistent, scannable format:

1. **Overview** - What the guide covers
2. **When to Use** - Specific triggers and scenarios
3. **Core Concepts** - Key principles
4. **Practical Examples** - Real-world code
5. **Common Pitfalls** - What to avoid
6. **Related Guides** - Cross-references

See [OpenCodeUsage/README.md](./OpenCodeUsage/README.md) for the complete index.

---

## 🔧 Customization Workflow

After running setup:

1. **Edit OPENCODE.md** - Fill in your project specifics
   - Project purpose
   - Tech stack
   - Architecture notes

2. **Create secrets files** (if needed)
   ```bash
   # For Python projects
   cp OpenCodeUsage/templates/secrets_template.json secrets_template.json
   cp secrets_template.json secrets.json
   # Edit secrets.json with real API keys
   ```

3. **Set up dependencies**
   ```bash
   # Python with UV
   uv init

   # JavaScript/Node
   npm init -y

   # Go
   go mod init yourproject
   ```

4. **Install git hooks** (recommended)
   ```bash
   # Interactive installer (auto-detects your language)
   ./OpenCodeUsage/pre_commit_hooks/install_hooks.sh

   # This installs:
   # - Code quality checks (formatters + linters)
   # - Security scanner (prevents API key leaks)
   # - Test runner (blocks push if tests fail)
   # - Dependency auto-updater
   ```

5. **Update TODOS.md** - Add your specific tasks

---

## 💡 Key Workflows

### Starting a New Feature

1. Check `TODOS.md` for pending tasks
2. Use @research to fetch relevant library docs
3. Follow git workflow for commits
4. Update TODOS.md as you progress

### Managing Secrets

1. Read `OpenCodeUsage/secrets_management.md`
2. Create `secrets.json` (gitignored)
3. Provide `secrets_template.json` for team
4. Use environment variable fallbacks

### Large Codebase Search

1. Use @research agent for 20+ file searches
2. Check `OpenCodeUsage/opencode_agents.md` for patterns
3. Use sub-agents for complex multi-step tasks

### Writing Tests

1. Review `OpenCodeUsage/testing_strategies.md`
2. Follow framework-specific patterns
3. Use test-strategist agent for planning

---

## 🔐 Security Defaults

This template includes security best practices by default:

- ✅ `secrets.json` in `.gitignore`
- ✅ **Pre-commit secrets scanner** - Detects 15+ secret patterns before commit
  - Anthropic, OpenAI, AWS, GitHub, Google API keys
  - JWT tokens, bearer tokens, private keys
  - Hardcoded passwords and database credentials
  - Actionable fix instructions when secrets detected
- ✅ Environment variable fallback patterns
- ✅ Security audit guides in `secrets_advanced.md`

---

## 🤖 Working with OpenCode

This template is optimized for OpenCode CLI. Key features:

- **OPENCODE.md** triggers automatic context loading
- **Structured guides** for quick reference without token bloat
- **Sub-agent workflows** for complex tasks
- **Git commit standards** with auto-formatting

### Example Session

```bash
cd ~/Projects/MyNewProject/

# OpenCode automatically reads OPENCODE.md and knows your project context
opencode "Add user authentication with JWT tokens"

# OpenCode will:
# 1. Check TODOS.md
# 2. Use @research to find relevant code
# 3. Use @planner to create implementation plan
# 4. Use @coder to implement changes
# 5. Use @git to review changes
# 6. Update TODOS.md
# 7. Commit with proper message format
```

---

## 📖 Learning Path

Recommended reading order for new projects:

1. **[project_structure.md](./OpenCodeUsage/project_structure.md)** - Directory layouts
2. **[git_guide.md](./OpenCodeUsage/git_guide.md)** - Version control and conventional commits
3. **[secrets_management.md](./OpenCodeUsage/secrets_management.md)** - API keys
4. **[uv_usage.md](./OpenCodeUsage/uv_usage.md)** - Python dependencies (if applicable)
5. **[testing_strategies.md](./OpenCodeUsage/testing_strategies.md)** - Test setup
6. **[opencode_agents.md](./OpenCodeUsage/opencode_agents.md)** - Advanced workflows

---

## 🆘 Troubleshooting

### "Git not initialized"

```bash
git init
git add .
git commit -m "Initial commit"
```

### "OPENCODE.md not found"

If you see this error, the setup script may not have run properly. Make sure you've run `bash setup.sh` in your project directory.

### "Pre-commit hooks not working"

```bash
chmod +x OpenCodeUsage/pre_commit_hooks/*
./OpenCodeUsage/pre_commit_hooks/install_hooks.sh
```

See [OpenCodeUsage/pre_commit_hooks/TROUBLESHOOTING.md](./OpenCodeUsage/pre_commit_hooks/TROUBLESHOOTING.md) for comprehensive hook troubleshooting.

---

## 🔄 Migration from Claude Code

If you're migrating from Claude Code to OpenCode:

### 1. Update Configuration Files

**CLAUDE.md → OPENCODE.md**
```bash
# Rename if it exists
mv CLAUDE.md OPENCODE.md

# Or copy the template
cp OpenCodeUsage/templates/OPENCODE_template.md OPENCODE.md
```

**.claude/ → .opencode/**
```bash
# Claude Code uses .claude/agents/
# OpenCode uses .opencode/agents/

# Move your existing agents
mv .claude/agents/* .opencode/agents/

# Or install the OpenCode agent suite
cp -r BaseProject/.opencode/agents/* .opencode/agents/
```

**claude.json → opencode.json**
```bash
# Convert your configuration
# Key differences:
# - OpenCode uses $schema: "https://opencode.ai/config.json"
# - Agent configuration structure is similar but uses OpenCode conventions
# - Tool names may differ (check OpenCode docs)
```

### 2. Update Agent References

**Claude Code syntax → OpenCode syntax**

```diff
- Use house-research to find all TODOs
+ @research find all TODOs

- Use house-git to review changes
+ @git review changes

- Use house-bash to run tests
+ @bash run tests
```

### 3. Update Documentation References

```diff
- See ClaudeUsage/git_guide.md
+ See OpenCodeUsage/git_guide.md

- Check CLAUDE.md for instructions
+ Check OPENCODE.md for instructions

- Generated with Claude Code
+ Generated with OpenCode
```

### 4. Update Git Commit Messages

```diff
- 🤖 Generated with [Claude Code](https://claude.ai/code)
+ 🤖 Generated with [OpenCode](https://opencode.ai)

- Co-Authored-By: Claude <noreply@anthropic.com>
+ Co-Authored-By: OpenCode <noreply@opencode.ai>
```

### 5. Test Your Agents

```bash
# Verify agents are loaded
opencode agent list

# Should show:
# - build (primary)
# - plan (primary)
# - research (subagent)
# - git (subagent)
# - bash (subagent)
# - mcp (subagent)
# - coder (subagent)
# - planner (subagent)

# Test an agent
opencode "@research find all Python files"
```

### 6. Update Git Hooks

If you were using Claude Code git hooks:

```bash
# Reinstall hooks for OpenCode
./OpenCodeUsage/pre_commit_hooks/install_hooks.sh

# This will:
# - Update hooks to reference OPENCODE.md
# - Update commit message format
# - Keep all the same functionality
```

### 7. Update CI/CD

```diff
# GitHub Actions example
- name: Check CLAUDE.md
- run: test -f CLAUDE.md
+ name: Check OPENCODE.md
+ run: test -f OPENCODE.md
```

### 8. Verify Configuration

```bash
# Check opencode.json is valid
opencode config validate

# Test a simple command
opencode "What is the project structure?"

# Should read OPENCODE.md and understand your project
```

---

## 📄 License

This template is provided as-is for use with OpenCode. Customize freely for your projects.

---

**Last updated:** 2025-11-09
**Maintained for:** OpenCode CLI
**Guides:** 17 comprehensive workflow documents
**Agents:** 6 specialized sub-agents