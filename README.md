# Infrastructure

Repository to gather terraform scripts for setting up identity base infrastructure and infrastructure for apps running
in the identity aws accounts.


## Installation

```bash
brew bundle
tfenv install
pre-commit install
```

## How to

Go to stack which you want to deploy in directory `environemts` i.e.

```bash
AWS_PROFILE=xxx terraform init
AWS_PROFILE=xxx terraform plan
AWS_PROFILE=xxx terraform apply
AWS_PROFILE=xxx terraform destroy
pre-commit run --all-files
pre-commit autoupdate
```


[GNU General Public License v3.0](LICENSE)
