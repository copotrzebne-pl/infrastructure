# Infrastructure

Repository to gather terraform scripts for setting up infrastructure for CoPotrzebne.pl.

## Folder structure

```
.
├── environments
│   ├── prod
│   └── staging
└── modules
    ├── certificate
    └── hosting_zone
```

### `environments`

Each of the environments is deployed separately and stored in a separate `tfstate`.

Main files:

* `backend.tf` - backed definition where state will be stored
* `env.auto.tfvars` - values for variables which could be stored in the repo (should not contains any creentials!)
* `main.tf` - the main fail with infrstructure - should contains only references to existing, reusable modules.
* `outputs.tf` - optional file with output variables
* `provider.tf` - provider configuration
* `variables.tf` - list of variables

### `modules`

Reusable Terraform modules.

Main files:

* `main.tf` - the main fail with infrastructure
* `outputs.tf` - optional file with output variables
* `variables.tf` - list of variables

## Getting Started

Instructions of setting up your project locally. Follow these simple steps.

### Prerequisites

* AWS profile configured for CLI
* Required software installed using commands:

  ```bash
  brew bundle
  tfenv install
  pre-commit install
  ```

### Usage

Here is a list of commands which you will find useful when working with this repo.

```bash
# Define which AWS credentials should be used
export AWS_PROFILE=copotrzebne-prod

# Load Terraform version based on .terraform-version file
tfenv use

# Go to stack which you want to deploy
cd environments/prod

# Verify files
pre-commit run --all-files

# Verify changes
terraform init
terraform plan

# Deploy changes
# Do it only when you are sure of what you are doing!
terraform apply
```

## Licence

[GNU General Public License v3.0](LICENSE)
