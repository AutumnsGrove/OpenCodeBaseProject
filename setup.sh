#!/bin/bash

# OpenCode BaseProject Setup Script
# Handles both new project initialization and adding to existing projects

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}ℹ️  ${1}${NC}"
}

log_success() {
    echo -e "${GREEN}✅ ${1}${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  ${1}${NC}"
}

log_error() {
    echo -e "${RED}❌ ${1}${NC}"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Print banner
print_banner() {
    echo ""
    echo -e "${BLUE}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                    OpenCode BaseProject                      ║${NC}"
    echo -e "${BLUE}║              Project Setup & Configuration                   ║${NC}"
    echo -e "${BLUE}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Setup for new project
setup_new_project() {
    print_banner
    log_info "Setting up NEW project..."
    
    # Check if OPENCODE.md exists
    if [ -f "OPENCODE.md" ]; then
        log_warning "OPENCODE.md already exists. Skipping creation."
    else
        # Copy OPENCODE.md template
        if [ -f "OpenCodeUsage/templates/OPENCODE_template.md" ]; then
            cp OpenCodeUsage/templates/OPENCODE_template.md OPENCODE.md
            log_success "Created OPENCODE.md"
        else
            log_warning "OPENCODE.md template not found. Creating basic version..."
            cat > OPENCODE.md << 'EOF'
# Project Instructions - OpenCode

## Project Purpose
[Fill in: What this project does - 1-2 sentences]

## Tech Stack
[Fill in: Technologies, frameworks, and languages used]

## Architecture Notes
[Fill in: Key architectural decisions, patterns, or structure]

## Essential Instructions
- Do what has been asked; nothing more, nothing less
- NEVER create files unless absolutely necessary
- ALWAYS prefer editing existing files to creating new ones
- Check TODOS.md first when starting a task
- Follow conventional commits format

For detailed guides, see: OpenCodeUsage/README.md
EOF
            log_success "Created basic OPENCODE.md"
        fi
    fi
    
    # Create TODOS.md if it doesn't exist
    if [ -f "TODOS.md" ]; then
        log_warning "TODOS.md already exists. Skipping creation."
    else
        cat > TODOS.md << 'EOF'
# Project TODOs

## High Priority
- [ ] Customize OPENCODE.md with project details
- [ ] Set up secrets.json for API keys (see OpenCodeUsage/secrets_management.md)
- [ ] Initialize git repository
- [ ] Install git hooks (./OpenCodeUsage/pre_commit_hooks/install_hooks.sh)

## Medium Priority
- [ ] Add project-specific documentation
- [ ] Set up testing framework
- [ ] Configure CI/CD pipeline

## Low Priority
- [ ] Add performance monitoring
- [ ] Set up error tracking
EOF
        log_success "Created TODOS.md"
    fi
    
    # Initialize git repository if not already initialized
    if [ -d ".git" ]; then
        log_info "Git repository already initialized."
    else
        log_info "Initializing git repository..."
        git init
        
        # Get git user info
        GIT_USER_NAME=$(git config --global user.name || echo "Developer")
        GIT_USER_EMAIL=$(git config --global user.email || echo "dev@example.com")
        
        git config user.name "$GIT_USER_NAME"
        git config user.email "$GIT_USER_EMAIL"
        
        log_success "Git repository initialized"
        log_info "Git user: $GIT_USER_NAME <$GIT_USER_EMAIL>"
    fi
    
    # Create .gitignore if it doesn't exist
    if [ -f ".gitignore" ]; then
        log_warning ".gitignore already exists. Merging with OpenCode defaults..."
        # Add OpenCode-specific entries if not present
        for pattern in "secrets.json" ".env" "__pycache__/" "*.pyc" ".venv" "venv/" ".DS_Store"; do
            if ! grep -q "^$pattern$" .gitignore; then
                echo "$pattern" >> .gitignore
                log_info "Added $pattern to .gitignore"
            fi
        done
    else
        cat > .gitignore << 'EOF'
# Secrets
secrets.json
.env
*.key
*.pem

# Python
__pycache__/
*.py[cod]
*$py.class
.env
.venv
venv/
*.egg-info/

# Node
node_modules/
.env.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Build
dist/
build/
*.egg-info/

# Testing
.coverage
.pytest_cache/
htmlcov/

# Logs
*.log
logs/
EOF
        log_success "Created .gitignore"
    fi
    
    # Create secrets_template.json
    if [ -f "secrets_template.json" ]; then
        log_warning "secrets_template.json already exists."
    else
        cat > secrets_template.json << 'EOF'
{
  "api_key": "YOUR_API_KEY_HERE",
  "database_url": "postgresql://user:pass@localhost/dbname",
  "jwt_secret": "YOUR_JWT_SECRET_HERE",
  "smtp_password": "YOUR_SMTP_PASSWORD_HERE"
}
EOF
        log_success "Created secrets_template.json"
        log_info "Copy to secrets.json and fill in your actual keys"
    fi
    
    # Detect tech stack and initialize
    detect_tech_stack
    
    # Install git hooks
    install_git_hooks
    
    # Make initial commit
    make_initial_commit
    
    # Print summary
    print_project_summary
}

# Add to existing project
add_to_existing_project() {
    print_banner
    log_info "Adding OpenCode BaseProject to EXISTING project..."
    
    # Backup existing files
    BACKUP_DIR=".baseproject-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    # Backup OPENCODE.md if it exists
    if [ -f "OPENCODE.md" ]; then
        cp OPENCODE.md "$BACKUP_DIR/OPENCODE.md.backup"
        log_info "Backed up existing OPENCODE.md"
    fi
    
    # Backup TODOS.md if it exists
    if [ -f "TODOS.md" ]; then
        cp TODOS.md "$BACKUP_DIR/TODOS.md.backup"
        log_info "Backed up existing TODOS.md"
    fi
    
    # Copy OPENCODE.md
    if [ -f "OpenCodeUsage/templates/OPENCODE_template.md" ]; then
        cp OpenCodeUsage/templates/OPENCODE_template.md OPENCODE.md
        log_success "Created OPENCODE.md"
    else
        log_warning "OPENCODE.md template not found. Creating basic version..."
        cat > OPENCODE.md << 'EOF'
# Project Instructions - OpenCode

## Project Purpose
[Fill in: What this project does - 1-2 sentences]

## Tech Stack
[Fill in: Technologies, frameworks, and languages used]

## Architecture Notes
[Fill in: Key architectural decisions, patterns, or structure]

## Essential Instructions
- Do what has been asked; nothing more, nothing less
- NEVER create files unless absolutely necessary
- ALWAYS prefer editing existing files to creating new ones
- Check TODOS.md first when starting a task
- Follow conventional commits format

For detailed guides, see: OpenCodeUsage/README.md
EOF
        log_success "Created basic OPENCODE.md"
    fi
    
    # Merge or create TODOS.md
    if [ -f "TODOS.md" ]; then
        log_info "Merging with existing TODOS.md..."
        cat >> TODOS.md << 'EOF'

## OpenCode BaseProject Integration
- [ ] Review OpenCodeUsage/README.md for available guides
- [ ] Customize OPENCODE.md with project-specific details
- [ ] Install git hooks (./OpenCodeUsage/pre_commit_hooks/install_hooks.sh)
- [ ] Set up secrets.json (see OpenCodeUsage/secrets_management.md)
EOF
        log_success "Updated TODOS.md"
    else
        cat > TODOS.md << 'EOF'
# Project TODOs

## OpenCode BaseProject Integration
- [ ] Review OpenCodeUsage/README.md for available guides
- [ ] Customize OPENCODE.md with project-specific details
- [ ] Install git hooks (./OpenCodeUsage/pre_commit_hooks/install_hooks.sh)
- [ ] Set up secrets.json (see OpenCodeUsage/secrets_management.md)
EOF
        log_success "Created TODOS.md"
    fi
    
    # Update .gitignore
    if [ -f ".gitignore" ]; then
        log_info "Updating .gitignore with OpenCode patterns..."
        for pattern in "secrets.json" ".env" "__pycache__/" "*.pyc" ".venv" "venv/" ".DS_Store"; do
            if ! grep -q "^$pattern$" .gitignore; then
                echo "$pattern" >> .gitignore
                log_info "Added $pattern to .gitignore"
            fi
        done
    else
        cat > .gitignore << 'EOF'
# Secrets
secrets.json
.env
*.key
*.pem

# Python
__pycache__/
*.py[cod]
*$py.class
.env
.venv
venv/
*.egg-info/

# Node
node_modules/
.env.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Build
dist/
build/
*.egg-info/

# Testing
.coverage
.pytest_cache/
htmlcov/

# Logs
*.log
logs/
EOF
        log_success "Created .gitignore"
    fi
    
    # Create secrets_template.json if it doesn't exist
    if [ ! -f "secrets_template.json" ]; then
        cat > secrets_template.json << 'EOF'
{
  "api_key": "YOUR_API_KEY_HERE",
  "database_url": "postgresql://user:pass@localhost/dbname",
  "jwt_secret": "YOUR_JWT_SECRET_HERE",
  "smtp_password": "YOUR_SMTP_PASSWORD_HERE"
}
EOF
        log_success "Created secrets_template.json"
    fi
    
    # Detect tech stack
    detect_tech_stack
    
    # Install git hooks
    install_git_hooks
    
    # Print summary
    print_integration_summary
}

# Detect tech stack and initialize
 detect_tech_stack() {
    log_info "Detecting tech stack..."
    
    # Check for Python
    if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ] || [ -f "setup.py" ] || [ -d "venv" ] || [ -d ".venv" ]; then
        log_info "Python project detected"
        
        # Check for UV
        if command_exists uv; then
            log_info "UV is available"
            if [ ! -f "pyproject.toml" ]; then
                log_info "Initializing UV project..."
                uv init
                log_success "Created pyproject.toml"
            fi
        else
            log_warning "UV not found. Install from: https://github.com/astral-sh/uv"
        fi
    fi
    
    # Check for Node.js
    if [ -f "package.json" ] || [ -d "node_modules" ]; then
        log_info "Node.js project detected"
        if command_exists npm; then
            log_info "npm is available"
        else
            log_warning "npm not found. Install Node.js from: https://nodejs.org"
        fi
    fi
    
    # Check for Go
    if [ -f "go.mod" ] || [ -d "vendor" ] || [ -f "main.go" ]; then
        log_info "Go project detected"
        if command_exists go; then
            log_info "Go is available"
        else
            log_warning "Go not found. Install from: https://golang.org"
        fi
    fi
    
    # Check for Rust
    if [ -f "Cargo.toml" ] || [ -d "target" ]; then
        log_info "Rust project detected"
        if command_exists cargo; then
            log_info "Cargo is available"
        else
            log_warning "Cargo not found. Install from: https://rustup.rs"
        fi
    fi
}

# Install git hooks
install_git_hooks() {
    log_info "Installing git hooks..."
    
    if [ -f "OpenCodeUsage/pre_commit_hooks/install_hooks.sh" ]; then
        chmod +x OpenCodeUsage/pre_commit_hooks/install_hooks.sh
        ./OpenCodeUsage/pre_commit_hooks/install_hooks.sh
        log_success "Git hooks installed"
    else
        log_warning "Git hooks installer not found. Skipping."
    fi
}

# Make initial commit
make_initial_commit() {
    if [ -d ".git" ]; then
        # Check if there are changes to commit
        if [ -n "$(git status --porcelain)" ]; then
            log_info "Creating initial commit..."
            git add .
            git commit -m "feat: Initialize project from OpenCode BaseProject

- Add OPENCODE.md with project instructions
- Add OpenCodeUsage/ guides
- Set up git hooks for code quality
- Create project structure

🤖 Generated with [OpenCode](https://opencode.ai)

Co-Authored-By: OpenCode <noreply@opencode.ai>"
            log_success "Initial commit created"
        else
            log_info "No changes to commit"
        fi
    fi
}

# Print project summary
print_project_summary() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                  Setup Complete! 🎉                          ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}What's been set up:${NC}"
    echo "  ✅ OPENCODE.md - Main project instructions"
    echo "  ✅ TODOS.md - Task tracking"
    echo "  ✅ .gitignore - Git ignore patterns"
    echo "  ✅ secrets_template.json - API key template"
    echo "  ✅ OpenCodeUsage/ - 17 workflow guides"
    echo "  ✅ .opencode/agents/ - 6 specialized agents"
    echo "  ✅ opencode.json - OpenCode configuration"
    echo "  ✅ Git hooks - Code quality & security"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Customize OPENCODE.md with your project details"
    echo "  2. Copy secrets_template.json to secrets.json and add API keys"
    echo "  3. Review TODOS.md and start with the first task"
    echo "  4. Read OpenCodeUsage/README.md for available guides"
    echo "  5. Test agents: '@research find all TODO comments'"
    echo ""
    echo -e "${BLUE}Quick start:${NC}"
    echo "  opencode 'What would you like to build?'"
    echo ""
}

# Print integration summary
print_integration_summary() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              Integration Complete! 🎉                        ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}What's been added:${NC}"
    echo "  ✅ OPENCODE.md - Project instructions (merged)"
    echo "  ✅ TODOS.md - Updated with integration tasks"
    echo "  ✅ .gitignore - Enhanced with OpenCode patterns"
    echo "  ✅ OpenCodeUsage/ - 17 workflow guides"
    echo "  ✅ .opencode/agents/ - 6 specialized agents"
    echo "  ✅ opencode.json - OpenCode configuration"
    echo "  ✅ Git hooks - Code quality & security"
    echo ""
    echo -e "${BLUE}Next steps:${NC}"
    echo "  1. Review and customize OPENCODE.md"
    echo "  2. Copy secrets_template.json to secrets.json if needed"
    echo "  3. Review updated TODOS.md"
    echo "  4. Test agents: '@research find all TODO comments'"
    echo "  5. Commit the integration: git add . && git commit -m 'chore: Integrate OpenCode BaseProject'"
    echo ""
}

# Main execution
main() {
    # Check if we're in the right directory
    if [ ! -d "OpenCodeUsage" ]; then
        log_error "OpenCodeUsage directory not found. Please run this script from the project root."
        exit 1
    fi
    
    # Parse arguments
    case "${1:-}" in
        "new")
            setup_new_project
            ;;
        "add")
            add_to_existing_project
            ;;
        "")
            # Auto-detect mode
            if [ -f "OPENCODE.md" ] && [ -d ".git" ]; then
                log_info "Existing project detected. Use './setup.sh add' to add OpenCode BaseProject."
                log_info "Or use './setup.sh new' to start fresh."
                echo ""
                read -p "Do you want to add to the existing project? (y/n) " -n 1 -r
                echo ""
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    add_to_existing_project
                else
                    log_info "Exiting. Run './setup.sh new' to start a new project or './setup.sh add' to add to existing."
                    exit 0
                fi
            else
                setup_new_project
            fi
            ;;
        *)
            echo "Usage: $0 [new|add]"
            echo ""
            echo "new  - Set up a NEW project from scratch"
            echo "add  - Add OpenCode BaseProject to an EXISTING project"
            echo ""
            echo "If no argument is provided, the script will auto-detect."
            exit 1
            ;;
    esac
}

# Run main function
main "$@"