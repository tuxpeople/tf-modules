# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a collection of reusable Terraform modules organized by cloud provider and service type. The repository contains modules for:

- **Azure**: Base infrastructure, Linux VMs, and subnet management
- **vSphere**: Virtual machine provisioning with template and OVF support
- **Rancher**: RKE2 cluster deployment and Rancher management server setup
- **UniFi**: DNS record management

## Architecture

### Module Structure
Each module follows a consistent structure:
- `main.tf` - Core resource definitions
- `variables.tf` - Input variables with descriptions and defaults
- `outputs.tf` - Output values for use by consuming modules
- `README.md` - Auto-generated documentation (managed by terraform-docs)
- `providers.tf` - Provider requirements (where needed)

### Key Patterns
- Modules use `random_pet` resources for generating unique names when `enable_pets = true`
- VSphere modules support both template cloning and OVF deployment
- RKE2 module handles both server and agent nodes with automatic token generation
- Azure modules create resource groups with optional naming conventions

## Common Commands

### Documentation and Formatting
```bash
# Format all Terraform files and regenerate documentation for all modules
./prepare.sh
```

This script:
1. Runs `terraform fmt -recursive` on each module
2. Generates README.md using `terraform-docs markdown table --output-file README.md --output-mode inject`
3. Commits changes with message "Script: Adjust formatting and docs"

### Per-Module Operations
```bash
# Format Terraform files in current module
terraform fmt -recursive

# Generate documentation for current module
terraform-docs markdown table --output-file README.md --output-mode inject ./

# Validate module
terraform validate

# Plan module (requires variables)
terraform plan
```

## Development Workflow

1. **Module Changes**: Make changes to `.tf` files in the appropriate module directory
2. **Format and Document**: Run `./prepare.sh` from root to format and update docs
3. **Validation**: Use `terraform validate` and `terraform plan` to verify changes
4. **Dependencies**: Renovate bot automatically manages provider version updates

## Module Dependencies

- **terraform-docs**: Required for generating module documentation
- **terraform**: For formatting, validation, and planning
- Modules specify provider requirements in `providers.tf` or use implicit latest versions
- Renovate configuration extends shared configs from `github>tuxpeople/shared`